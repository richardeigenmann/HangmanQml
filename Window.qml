import QtQuick.Window
import QtQuick
import QtQuick.Controls

//ApplicationWindow {
Window {
    //id: window
    title: qsTr("Hangman Game")
    width: 820; height: 370
    visible: true
    Game {}
}
