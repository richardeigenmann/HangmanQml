import QtQuick.Window 2.13
import QtQuick 2.13
import QtQuick.Controls 1.5

//ApplicationWindow {
Window {
    //id: window
    title: qsTr("Hangman Game")
    width: 820; height: 370
    visible: true
    Game {}
}
