import QtQuick 2.12
import "script.js" as MyScript

Item {
    id: root
    signal refresh()

    Row {
        id: myWord
        spacing: 4

        Repeater {
            model: MyScript.secretWord.length
            id: myRepeater
            Letter {
                id: myLetter
                realChar: MyScript.secretWord.charAt(index)
                state: MyScript.pickedLetters.has(realChar) ? "showing" : "obscured"
                Component.onCompleted: {
                    root.refresh.connect(reassessState)
                }
                function reassessState() {
                    state= MyScript.pickedLetters.has(realChar) ? "showing" : "obscured"
                }
            }
        }
    }
}
