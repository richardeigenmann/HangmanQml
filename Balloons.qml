import QtQuick 2.0
import QtQml.Models 2.1

Item {
    id: root

    property int count: 0
    signal die()
    property variant balloonColors: ["green","yellow","blue","red","pink"]

    ObjectModel {
        id: balloonModel
    }

    function createBalloons() {
        balloonModel.clear();
        [...Array(count)].forEach(( _, index) =>{
                                      var component = Qt.createComponent("Balloon.qml");
                                      balloonModel.append(component.createObject(root, {color: balloonColors[index % balloonColors.length]}));
                                  });
    }

    PathView {
        anchors.fill: parent
        model: balloonModel

        path: Path {
            startX: 40; startY: 35
            PathQuad { x: 140; y: 40; controlX: 80; controlY: 95 }
            PathQuad { x: 20; y: 50; controlX: 80; controlY: 5 }
        }
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
        },
        State {
            name: "alive";
            PropertyChanges { target: maninchair; y: 110; rotation: 0; }
        }
    ]

    transitions: Transition {
        from: "alive"; to: "dead"; reversible: false
        ParallelAnimation {
            NumberAnimation { properties: "y,rotation"; duration: 160; easing.type: Easing.InOutQuad }
        }
    }

    onDie: {
        root.state = "dead"
    }

    function burstOne() {
        count--;
        balloonModel.get(count).state= "deflated";
        if ( count < 1 ) {
            die();
        }
    }
}
