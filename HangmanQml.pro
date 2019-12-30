QT += qml quick widgets svg

CONFIG += c++17

RESOURCES += HangmanQml.qrc

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
    main.cpp \
    message.cpp

DISTFILES += \
    Readme.md

HEADERS += \
    message.h

#QMAKE_LFLAGS += --emrun
