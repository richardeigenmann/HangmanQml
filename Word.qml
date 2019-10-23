import QtQuick 2.12
import "script.js" as MyScript

Item {
    id: root
    signal refresh()
    property string myWord: ""

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
                    console.log("Word reassessState ", realChar );
                    MyScript.showPickedLetters();
                    state= MyScript.pickedLetters.has(realChar) ? "showing" : "obscured"
                }
            }
        }
    }
}
