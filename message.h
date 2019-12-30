#pragma once
#include <QObject>
#include <QDebug>

class Message : public QObject {

    Q_OBJECT

    public:
        explicit Message(QObject *parent=nullptr);

    public slots:
        QString doMessageChange(QString msg);

    private:
        explicit Message ( const Message & rhs ) = delete;
        Message& operator= ( const Message & rhs ) = delete;
};