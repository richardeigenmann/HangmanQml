import QtQuick 2.0

Item {
    id: container
    property alias letter: myChar.text
    signal clicked(string clickedChar)

    width: 40; height: 40

    Rectangle {
        id: rectangle
        border.color: "white"
        anchors.fill: parent

        Text {
            id: myChar
            text: "_"
            //anchors.horizontalCenter: parent.horizontalCenter
            //anchors.verticalCenter: parent.verticalCenter
            anchors.centerIn: parent
            font.pointSize: 24; font.bold: true      
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: handlePickEvent()
    }

    function handlePickEvent() {
        container.clicked(container.letter)
        container.letter = '_'
    } 
}
