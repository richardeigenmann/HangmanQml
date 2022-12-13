QT += qml quick widgets core svg

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

CONFIG(debug, debug|release) {
    DESTDIR = build/debug
} else {
    DESTDIR = build/release
}

#QMAKE_LFLAGS += --emrun
