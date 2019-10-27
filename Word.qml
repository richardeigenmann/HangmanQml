import QtQuick 2.12
import "script.js" as MyScript

Item {
    id: root
    signal refresh()
    property string myWord: ""
    state: "initializing"
    onStateChanged: root.refresh()

    Row {
        id: myWord
        spacing: 4

        Repeater {
            model: root.myWord.length
            id: myRepeater
            Letter {
                id: myLetter
                realChar: root.myWord.charAt(index)
                state: MyScript.pickedLetters.has(realChar) ? "showing" : "obscured"
                Component.onCompleted: {
                    root.refresh.connect(reassessState)
                }
                function reassessState() {
                    state = MyScript.pickedLetters.has(realChar) || root.state == "won" || root.state == "dead" ? "showing" : "obscured"
                }
            }
        }
    }

    states: [
        State {
            name: "initializing";
        },
        State {
            name: "playing";
        },
        State {
            name: "won";
        },
        State {
            name: "dead";
        }
    ]

}
