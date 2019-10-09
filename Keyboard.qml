import QtQuick 2.0

Item {
    id: container
    signal picked(string pickedChar)
   
    Grid {
        id: keyboardGrid
        rows: 3; columns: 10; spacing: 10

        Letter { letter: "A"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "B"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "C"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "D"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "E"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "F"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "G"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "H"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "I"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "J"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "K"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "L"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "M"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "N"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "O"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "P"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "Q"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "R"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "S"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "T"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "U"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "V"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "W"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "X"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "Y"; onClicked: letterPicked(clickedChar) }
        Letter { letter: "Z"; onClicked: letterPicked(clickedChar) }
    }

    function letterPicked(pickedChar) {
        container.picked(pickedChar)
    }
}