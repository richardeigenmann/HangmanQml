#include "message.h"
#include <iostream>

Message::Message(QObject *parent) : QObject(parent) {

}

void Message::doMessageChange() {
    std::cout << "We are in C++!" << std::endl;
}