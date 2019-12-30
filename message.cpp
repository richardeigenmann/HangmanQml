#include "message.h"
#include <iostream>

Message::Message(QObject *parent) : QObject(parent) {

}

QString Message::doMessageChange(QString msg) {
    qDebug() << "We are in C++ and received: " << msg;
    std::cout << msg.toStdString() << std::endl;
    return QString("This came from C++");
}