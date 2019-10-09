import QtQuick 2.0

Item {
    id: container

    Component.onCompleted: {
        var b;
        var sprite;
        b = Qt.createComponent("Balloon.qml");
        sprite = b.createObject(container, {x: 5, y: 5, color: "green" });
        sprite = b.createObject(container, {x: 40, y: 2, color: "yellow" });
        sprite = b.createObject(container, {x: 75, y: 8, color: "blue" });
        sprite = b.createObject(container, {x: 25, y: 25, color: "red" });
        sprite = b.createObject(container, {x: 65, y: 25, color: "pink" });
    }

    Image {
        id: maninchair
        source: "maninchair.png"
        x:40
        y:110
        MouseArea { 
            id: mouseArea; anchors.fill: parent 
            onClicked: die()
        }
    }

    states: [
        State {
            name: "dead";
            // when: mouseArea.pressed == true
            PropertyChanges { target: maninchair; y: 220; rotation: 180; }
        }
    ]

    transitions: Transition {
        from: ""; to: "dead"; reversible: false
        ParallelAnimation {
            NumberAnimation { properties: "y,rotation"; duration: 160; easing.type: Easing.InOutQuad }
        }
    }

    function die() {
        container.state = "dead"
    }
}