import QtQuick 2.13

Item {
    id: root
    property int count: 0
    property variant balloonColors: ["green","yellow","blue","red","pink"]
    property int hookX : 75
    property int hookY : 160

    onCountChanged: {
        myCanvas.requestPaint();
    }

    Component {
        id: itemDelegate
        Balloon {
            width: 50
            height: 70
            hookX: root.hookX
            hookY: root.hookY
            balloonColor: root.balloonColors[index % root.balloonColors.length]
        }
    }

    PathView {
        id: myPathView
        anchors.fill: parent
        model: root.count
        delegate: itemDelegate

        path: Path {
            startX: 40; startY: 35
            PathQuad { x: 140; y: 40; controlX: 80; controlY: 95 }
            PathQuad { x: 20; y: 50; controlX: 80; controlY: 5 }
        }
    }


    Canvas {
        id: myCanvas
        width: 200
        height: 300
        onPaint: {
            const ctx = getContext("2d")
            ctx.reset();

            // figure out the order in which to draw the balloons by sorting
            // them in z order.
            function compare( a, b ) {
                if ( a.z < b.z ){
                    return -1;
                }
                if ( a.z > b.z ){
                    return 1;
                }
                return 0;
            }

            let zOrderMap = new Map();
            for (var i=1; i<=root.count; i++) {
                zOrderMap.set(i, myPathView.children[i].z);
            }

            const sortedZOrderMap = new Map([...zOrderMap.entries()].sort((a, b) => b[1] - a[1]));

            // draw the balloons in z-order
            for ( let i of sortedZOrderMap.keys() ) {
                myPathView.children[i].drawBalloon(ctx);
            }
        }
    }


}
