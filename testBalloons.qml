import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    width: 400; height: 300


    Balloons {
        id: balloons
        x: 100
        y: 20
    }

    SpinBox {
        id: mySpinBox
        x: 130
        y: 220
        value: 4
        onValueModified: {
            balloons.count = value;
        }
    }

}
