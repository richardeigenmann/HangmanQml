#pragma once
#include <QObject>

class Message : public QObject {

    Q_OBJECT

    public:
        explicit Message(QObject *parent=nullptr);

    public slots:
        void doMessageChange();

    private:
        explicit Message ( const Message & rhs ) = delete;
        Message& operator= ( const Message & rhs ) = delete;
};