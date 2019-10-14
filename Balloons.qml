import QtQuick 2.0

Item {
    id: root

    property int count: 0
    signal die()

    Component.onCompleted: {
        var b;
        var sprite;
        b = Qt.createComponent("Balloon.qml");
        sprite = b.createObject(root, {x: 5, y: 5, color: "green" });
        sprite = b.createObject(root, {x: 40, y: 2, color: "yellow" });
        sprite = b.createObject(root, {x: 75, y: 8, color: "blue" });
        sprite = b.createObject(root, {x: 25, y: 25, color: "red" });
        sprite = b.createObject(root, {x: 65, y: 25, color: "pink" });
    }


    Text {
        text: root.count
        x: 5
        y: 70
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
            PropertyChanges { target: maninchair; y: 220; rotation: 180; }
        }
    ]

    transitions: Transition {
        from: ""; to: "dead"; reversible: false
        ParallelAnimation {
            NumberAnimation { properties: "y,rotation"; duration: 160; easing.type: Easing.InOutQuad }
        }
    }

    onDie: {
        root.state = "dead"
    }

    function burstOne() {
        count--;
        if ( count < 1 ) {
            die();
        }

    }
}
