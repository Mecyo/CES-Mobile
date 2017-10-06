#include <QFile>
#include <QGuiApplication>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonParseError>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <QVariant>

#include "requesthttp.h"

QVariant readFile(const QString &path)
{
    QFile file(path);
    QJsonParseError error;
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return QVariant();
    QByteArray fileContent(file.readAll());
    file.close();
    QJsonDocument jsonDocument = QJsonDocument::fromJson(fileContent, &error);
    if (error.error == QJsonParseError::NoError && !jsonDocument.isEmpty()) {
        if (jsonDocument.isArray())
            return jsonDocument.array().toVariantList();
        else if (jsonDocument.isObject())
            return jsonDocument.object().toVariantMap();
    }
    return fileContent;
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication qApplication(argc, argv);
    QQuickStyle::setStyle(QStringLiteral("Material"));

    qmlRegisterType<RequestHttp>("RequestHttp", 1, 0, "RequestHttp");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(QLatin1String("Settings"), readFile(":/Settings.json"));

    engine.load(QUrl(QLatin1String("qrc:/Main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return qApplication.exec();
}
