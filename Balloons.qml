import QtQuick 2.0

Item {
    id: root

    property int count: 0
    signal die()
    property variant balloonColors: ["green","yellow","blue","red","pink"]

    Component {
        id: delegate
        Column {
            id: wrapper
            Balloon{ color: balloonColors[index % balloonColors.length] }
        }
    }

    PathView {
        anchors.fill: parent
        delegate: delegate
        model: root.count

        path: Path {
            startX: 40; startY: 35
            PathQuad { x: 140; y: 40; controlX: 80; controlY: 95 }
            PathQuad { x: 20; y: 50; controlX: 80; controlY: 5 }
        }
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
