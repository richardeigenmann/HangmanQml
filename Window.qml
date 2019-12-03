import QtQuick.Window 2.13
import QtQuick 2.0
import QtQuick.Controls 1.5

ApplicationWindow {
    id: root
    title: qsTr("Hangman Game")
    width: 820; height: 370
    visible: true
    Game {}
}
