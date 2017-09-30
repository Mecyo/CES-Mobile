#include "requesthttp.h"

#include <QFile>
#include <QFileInfo>
#include <QHttpPart>
#include <QHttpMultiPart>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QList>
#include <QMapIterator>
#include <QMimeDatabase>
#include <QNetworkRequest>
#include <QUrl>
#include <QUrlQuery>

const QString RequestHttp::m_stateError = QStringLiteral("error");
const QString RequestHttp::m_stateFinished = QStringLiteral("finished");
const QString RequestHttp::m_stateLoading = QStringLiteral("loading");
const QByteArray RequestHttp::m_authorizationKey = "Authorization";
const QByteArray RequestHttp::m_defaultContentTypeHeader = "Application/Json";

RequestHttp::RequestHttp(QObject *parent) : QObject(parent)
{
    setConnections();
}

RequestHttp::RequestHttp(const RequestHttp &other) : QObject()
  ,m_baseUrl(other.m_baseUrl)
  ,m_basicAuthorizationUser(other.m_basicAuthorizationUser)
  ,m_basicAuthorizationPassword(other.m_basicAuthorizationPassword)
  ,m_state("")
  ,m_jsonParseError(other.m_jsonParseError)
  ,m_basicAuthorization(other.m_basicAuthorization)
  ,m_result("")
{
    setConnections();
}

RequestHttp::~RequestHttp()
{
}

void RequestHttp::setBasicAuthorizationUser(const QString &user)
{
    m_basicAuthorizationUser = user;
    if (!m_basicAuthorizationPassword.isEmpty())
        setBasicAuthorization(m_basicAuthorizationUser, m_basicAuthorizationPassword);
}

void RequestHttp::setBasicAuthorizationPassword(const QString &password)
{
    m_basicAuthorizationPassword = password;
    if (!m_basicAuthorizationUser.isEmpty())
        setBasicAuthorization(m_basicAuthorizationUser, m_basicAuthorizationPassword);
}

QString RequestHttp::basicAuthorizationUser() const
{
    return m_basicAuthorizationUser;
}

QString RequestHttp::basicAuthorizationPassword() const
{
    return m_basicAuthorizationPassword;
}

QString RequestHttp::url() const
{
    return m_baseUrl;
}

QString RequestHttp::state() const
{
    return m_state;
}

QString RequestHttp::stateError() const
{
    return m_stateError;
}

QString RequestHttp::stateFinished() const
{
    return m_stateFinished;
}

QString RequestHttp::stateLoading() const
{
    return m_stateLoading;
}

void RequestHttp::setBasicAuthorization(const QString &username, const QString &password)
{
    if (username.isEmpty() || password.isEmpty())
        return;
    QString usernameAndPassword(username + ":" + password);
    m_basicAuthorization = "Basic " + QByteArray(usernameAndPassword.toLocal8Bit().toBase64());
}

void RequestHttp::setConnections()
{
    connect(&m_networkAccessManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(requestFinished(QNetworkReply*)));
}

QUrlQuery RequestHttp::urlQueryFromMap(const QVariantMap &map)
{
    QUrlQuery qUrlQuery;
    QMapIterator<QString, QVariant> i(map);
    while (i.hasNext()) {
        i.next();
        qUrlQuery.addQueryItem(i.key(), i.value().toString());
    }
    return qUrlQuery;
}

void RequestHttp::setState(const QString &state)
{
    m_state = state;
    emit stateChanged(m_state);
}

void RequestHttp::setUrl(const QString &url)
{
    m_baseUrl = url;
    emit baseUrlChanged(m_baseUrl);
}

void RequestHttp::setHeaders(const QVariantMap &requestHeaders, QNetworkRequest *request)
{
    QMapIterator<QString, QVariant> i(requestHeaders);
    while (i.hasNext()) {
        i.next();
        request->setRawHeader(i.key().toUtf8(), i.value().toByteArray());
    }
}

bool RequestHttp::setMultiPartRequest(QHttpMultiPart *httpMultiPart, const QString &filePath)
{
    QString fpath(filePath);

    if (fpath.contains("file://"))
        fpath.replace("file://", "");

#ifdef Q_OS_IOS
    QUrl url(fpath);
    fpath = url.toLocalFile();
#endif

    QFile *file = new QFile(fpath);

    if (!file->exists()) {
        delete file;
        emit error(404, QVariant("File '"+fpath+"' not found! Request aborted!"));
        return false;
    } else if (!file->open(QIODevice::ReadOnly)) {
        delete file;
        emit error(400, QVariant("File '"+fpath+"' cannot be open! Request aborted!"));
        return false;
    }

    // get the file name:
    // if the file is> /home/user/Downloads/linux_files/archive.tar.gz
    // the fpath is: archive.tar.gz
    fpath = QFileInfo(*(file)).fileName().trimmed();

    QHttpPart filePart;
    // content disposition is required by server side upload file manager
    filePart.setHeader(QNetworkRequest::ContentDispositionHeader, QString("multipart/form-data; filename=%1; file=%2; name=file").arg(fpath, fpath));
    // content disposition is the file mime-type
    filePart.setHeader(QNetworkRequest::ContentTypeHeader, QMimeType(QMimeDatabase().mimeTypeForFile(fpath)).name());
    // set the parent to file not be deleted
    file->setParent(httpMultiPart);
    // the file will be loaded as binary data
    filePart.setBodyDevice(file);
    // append the filePart to request multi part data
    httpMultiPart->append(filePart);

    return true;
}

void RequestHttp::uploadProgress(qint64 a, qint64 b)
{
    emit uploadProgressChanged(a, b);
}

void RequestHttp::uploadFile(const QString &url, const QStringList &filePathsList, const QVariantMap &headers, bool usesPutMethod)
{
    // to upload file (.jpg, .pdf, .doc, .zip) in Qt, the QHttpMultiPart is a object
    // that encapsulates the files as binary data where be sent in put or post request method
    QHttpMultiPart *multiPart = new QHttpMultiPart(QHttpMultiPart::FormDataType);

    // for each filepath, create a bodyDevice part to append in multiPart
    foreach (const QString &item, filePathsList) {
        if (!setMultiPartRequest(multiPart, item)) {
            // if the file cannot be read or access denied by OS, the request finish now!
            // and multiPart pointer needs to be deleted!
            delete multiPart;
            return;
        }
    }

    // request handle the url, args and headers
    QNetworkRequest request(m_baseUrl.isEmpty() || url.contains("http") ? url : m_baseUrl + url);

    // set the request autorization if isset
    if (!m_basicAuthorization.isEmpty())
        request.setRawHeader(m_authorizationKey, m_basicAuthorization);

    // set custom headers if pass in parameter
    if (headers.size())
        setHeaders(headers, &request);

    // set state to loading
    setState(m_stateLoading);

    QNetworkReply *reply = nullptr;

    // start the request
    if (usesPutMethod)
        reply = m_networkAccessManager.put(request, multiPart);
    else
        reply = m_networkAccessManager.post(request, multiPart);

    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(requestError(QNetworkReply::NetworkError)));
    connect(reply, SIGNAL(uploadProgress(qint64, qint64)), this, SLOT(uploadProgress(qint64, qint64)));

    // multiPart will be deleted with the reply
    multiPart->setParent(reply);
    if (reply)
        reply->setParent(this);
}

void RequestHttp::get(const QString &url, const QVariantMap &urlArgs, const QVariantMap &headers)
{
    QUrl qurl(m_baseUrl.isEmpty() || url.contains("http") ? url : m_baseUrl + url);
    QNetworkRequest request(qurl);
    request.setHeader(QNetworkRequest::ContentTypeHeader, m_defaultContentTypeHeader);
    request.setAttribute(QNetworkRequest::FollowRedirectsAttribute, true);

    if (urlArgs.size())
        qurl.setQuery(urlQueryFromMap(urlArgs));

    if (!m_basicAuthorization.isEmpty())
        request.setRawHeader(m_authorizationKey, m_basicAuthorization);

    if (headers.size())
        setHeaders(headers, &request);

    setState(m_stateLoading);
    QNetworkReply *reply = m_networkAccessManager.get(request);
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(requestError(QNetworkReply::NetworkError)));
    if (reply)
        reply->setParent(this);
}

void RequestHttp::post(const QString &url, const QVariant &postData, const QVariantMap &headers)
{
    QNetworkRequest request(m_baseUrl.isEmpty() || url.contains("http") ? url : m_baseUrl + url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, m_defaultContentTypeHeader);
    request.setAttribute(QNetworkRequest::FollowRedirectsAttribute, true);

    if (!m_basicAuthorization.isEmpty())
        request.setRawHeader(m_authorizationKey, m_basicAuthorization);

    if (!headers.isEmpty())
        setHeaders(headers, &request);

    setState(m_stateLoading);
    QNetworkReply *reply = m_networkAccessManager.post(request, postData.toByteArray());
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(requestError(QNetworkReply::NetworkError)));
    if (reply)
        reply->setParent(this);
}

void RequestHttp::requestFinished(QNetworkReply *reply)
{
    if (!reply)
        return;
    int statusCode = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    if (reply->isFinished()) {
        m_result = reply->readAll();
        setState(m_stateFinished);
        if (!m_result.isEmpty()) {
            m_json = QJsonDocument::fromJson(m_result, &m_jsonParseError);
            // json is invalid
            if (m_jsonParseError.error != QJsonParseError::NoError)
                emit finished(statusCode, QVariantMap());
            else if (m_json.isObject() && !m_json.isEmpty())
                emit finished(statusCode, m_json.object().toVariantMap());
            else if (m_json.isArray() && !m_json.isEmpty())
                emit finished(statusCode, m_json.array().toVariantList());
        } else {
            if (statusCode <= 0)
                requestError(reply->error());
            else
                emit finished(statusCode, m_result);
        }
        // delet the reply with all files object if request upload files
        reply->deleteLater();
    } else if (!reply->isRunning()) {
        requestError(reply->error());
        // delet the reply with all files object if request upload files
        reply->deleteLater();
    }
}

void RequestHttp::requestError(QNetworkReply::NetworkError code)
{
    setState(m_stateError);
    emit error(code, QString("Network reply with error code %1").arg(code));
}
