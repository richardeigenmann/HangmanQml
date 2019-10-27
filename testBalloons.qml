import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

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
