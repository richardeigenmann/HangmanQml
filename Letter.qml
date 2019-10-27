import QtQuick 2.0

Item {
    id: root
    property string realChar: ""
    width: 40; height: 40
    signal clicked(string clickedChar)

    Rectangle {
        id: rectangle
        border.color: "white"
        anchors.fill: parent
        state: "showing"

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
        onClicked: root.clicked(root.realChar)
    }

    states: [
        State {
            name: "obscured";
            PropertyChanges { target: myChar; text: '_' }
        },
        State {
            name: "showing";
            PropertyChanges { target: myChar; text: root.realChar }
        }
    ]
}
