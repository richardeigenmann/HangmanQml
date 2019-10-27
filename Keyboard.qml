import QtQuick 2.0

Item {
    id: root
    signal picked(string pickedChar)
    signal reset
   
    Grid {
        id: keyboardGrid
        rows: 3; columns: 10; spacing: 10

        Repeater {
            model: 26
            Letter {
                realChar: String.fromCharCode(65 + index);
                state: "showing"
                onClicked: {
                    if ( state == "showing" ) {
                        state= "obscured";
                        root.picked(clickedChar);
                    }
                }
                Component.onCompleted: {
                    root.reset.connect(resetState)
                }
                function resetState() {
                    state = "showing";
                }
            }
        }
    }
}
