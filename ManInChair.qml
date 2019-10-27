import QtQuick 2.0

Image {
    id: root
    source: "maninchair.png"
    state: "alive"

    states: [
        State {
            name: "alive";
            PropertyChanges { target: root; y: 160; rotation: 0; }
        },
        State {
            name: "dead";
            PropertyChanges { target: root; y: 220; rotation: 180; }
        }
    ]

    transitions: Transition {
        from: "alive"; to: "dead"; reversible: false
        ParallelAnimation {
            NumberAnimation { properties: "y,rotation"; duration: 160; easing.type: Easing.InOutQuad }
        }
    }

}
