import QtQuick 2.0

Item {
    id: container
    signal picked(string pickedChar)
   
    Grid {
        id: keyboardGrid
        rows: 3; columns: 10; spacing: 10

        Repeater {
            model: 26
            Letter { letter: String.fromCharCode(65 + index); onClicked: letterPicked(clickedChar) }
        }
    }

    function letterPicked(pickedChar) {
        container.picked(pickedChar)
    }
}
