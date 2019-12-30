#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "message.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QUrl source(QStringLiteral("qrc:/Window.qml"));
    QQmlApplicationEngine engine;
    Message my_msg;
    auto root_context = engine.rootContext();
    root_context->setContextProperty( "messageClass", &my_msg);

    //qmlRegisterType<FileIO>("org.fileio", 1, 0, "FileIO");
    engine.load(source);
    return app.exec();
}
