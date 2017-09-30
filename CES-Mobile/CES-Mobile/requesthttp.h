#ifndef REQUESTHTTP_H
#define REQUESTHTTP_H

#include <QJsonParseError>
#include <QJsonValue>
#include <QNetworkReply>
#include <QNetworkAccessManager>
#include <QObject>

class QUrl;
class QFile;
class QFileInfo;
class QHttpPart;
class QHttpMultiPart;
class QMimeDatabase;
class QNetworkRequest;
class QUrlQuery;

class RequestHttp : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString stateError READ stateError CONSTANT)
    Q_PROPERTY(QString stateFinished READ stateFinished CONSTANT)
    Q_PROPERTY(QString stateLoading READ stateLoading CONSTANT)
    Q_PROPERTY(QString state READ state NOTIFY stateChanged)
    Q_PROPERTY(QString baseUrl READ url WRITE setUrl READ url NOTIFY baseUrlChanged)
    Q_PROPERTY(QString basicAuthorizationUser READ basicAuthorizationUser WRITE setBasicAuthorizationUser)
    Q_PROPERTY(QString basicAuthorizationPassword READ basicAuthorizationPassword WRITE setBasicAuthorizationPassword)
public:
    explicit RequestHttp(QObject *parent = nullptr);
    RequestHttp(const RequestHttp &other);
    ~RequestHttp();

    void setUrl(const QString &url);
    void setBasicAuthorizationUser(const QString &user);
    void setBasicAuthorizationPassword(const QString &password);

    QString basicAuthorizationUser() const;
    QString basicAuthorizationPassword() const;
    QString url() const;
    QString state() const;

    QString stateError() const;
    QString stateFinished() const;
    QString stateLoading() const;

    Q_INVOKABLE
    void setBasicAuthorization(const QString &user, const QString &password);

    Q_INVOKABLE
    void uploadFile(const QString &url, const QStringList &filePathsList, const QVariantMap &headers = QVariantMap(), bool usesPutMethod = false);

    Q_INVOKABLE
    void get(const QString &url, const QVariantMap &urlArgs = QVariantMap(), const QVariantMap &headers = QVariantMap());

    Q_INVOKABLE
    void post(const QString &url, const QVariant &postData, const QVariantMap &headers = QVariantMap());

private:
    void setConnections();
    QUrlQuery urlQueryFromMap(const QVariantMap &map);
    void setState(const QString &state);
    void setHeaders(const QVariantMap &requestHeaders, QNetworkRequest *request);
    bool setMultiPartRequest(QHttpMultiPart *httpMultiPart, const QString &fpath);

signals:
    void uploadProgressChanged(qint64 a, qint64 b);
    void stateChanged(const QString &state);
    void baseUrlChanged(const QString &url);
    void error(int statusCode, const QVariant &message);
    void finished(int statusCode, const QVariant &response);

private slots:
    void uploadProgress(qint64 a, qint64 b);
    void requestFinished(QNetworkReply *reply);
    void requestError(QNetworkReply::NetworkError code);

private:
    static const QString m_stateError;
    static const QString m_stateFinished;
    static const QString m_stateLoading;
    static const QByteArray m_authorizationKey;
    static const QByteArray m_defaultContentTypeHeader;
    QString m_baseUrl;
    QString m_basicAuthorizationUser;
    QString m_basicAuthorizationPassword;
    QString m_state;
    QJsonParseError m_jsonParseError;
    QByteArray m_basicAuthorization;
    QNetworkAccessManager m_networkAccessManager;
    QByteArray m_result;
    QJsonDocument m_json;
    QJsonValue m_jsonValue;
};

#endif // REQUESTHTTP_H
