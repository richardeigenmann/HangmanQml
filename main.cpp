#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QUrl source(QStringLiteral("qrc:/Window.qml"));
    QQmlApplicationEngine engine;
    //qmlRegisterType<FileIO>("org.fileio", 1, 0, "FileIO");
    engine.load(source);
    return app.exec();
}
