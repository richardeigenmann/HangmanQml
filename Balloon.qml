import QtQuick 2.0

Rectangle {
    id: root
    width: 50
    height: 70
    color: "red"
    border.color: "black"
    border.width: 2
    radius: width*0.5
    state: "inflated"

    states: [
        State {
            name: "inflated";
            PropertyChanges { target: root; scale: 1; }
        },
        State {
            name: "deflated";
            PropertyChanges { target: root; scale: 0; }
        }
    ]

    transitions: Transition {
        from: "inflated"; to: "deflated"; reversible: false
        NumberAnimation { properties: "scale"; duration: 260; easing.type: Easing.linear }
    }
}

