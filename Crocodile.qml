import QtQuick 2.0

Image {
    id: root
    source: "crocodile.svg"
    width: 100
    height: 110
    state: "hidden"

    states: [
        State {
            name: "hidden";
            PropertyChanges { target: root; y: 300 }
        },
        State {
            name: "hungry";
            PropertyChanges { target: root; y: 250 }
        },
        State {
            name: "feeding";
            PropertyChanges { target: root; y: 220 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "y"; duration: 1000 }
    }

}
