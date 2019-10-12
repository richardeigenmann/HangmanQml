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
            font.family: "Bungee"
            anchors.centerIn: parent
            color: "#303030"
            font.pointSize: 24;
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: handlePickEvent()
    }

    function handlePickEvent() {
        container.clicked(container.letter)
        //container.letter = '_'
        this.state = "obscured"
    }

    states: [
        State {
            name: "obscured";
            PropertyChanges { target: myChar; text: '_' }
        },
        State {
            name: "showing";
            PropertyChanges { target: myChar; text: '_' }
        }
    ]
}
