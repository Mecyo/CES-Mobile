#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "sortfilterproxymodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<SortFilterProxyModel>("SortFilterProxyModel", 0, 1, "SortFilterProxyModel");
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    return app.exec();
}
