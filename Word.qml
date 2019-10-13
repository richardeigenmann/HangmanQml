import QtQuick 2.12
import "script.js" as MyScript

Item {
    id: root

    Row {
        id: myWord
        spacing: 4

        Repeater {
            model: MyScript.secretWord.length
            id: myRepeater
            Letter {
                id: myLetter
                //letter: MyScript.secretWord.charAt(index)
                realChar: MyScript.secretWord.charAt(index)
                state: MyScript.pickedLetters.has(realChar) ? "showing" : "obscured"
                //letter: Qt.binding(function() { return MyScript.getLetter(index) })
                //letter: Qt.binding(function() { return "!"})
                Timer {
                    repeat: true
                    interval: 500
                    running: true
                    onTriggered: {
                        console.log("onTriggered", index, MyScript.getLetter(index));
                        parent.state = MyScript.pickedLetters.has(parent.realChar) ? "showing" : "obscured" }
                }
                /*onClicked: {
                    console.log( "onClicked: " + index, MyScript.getLetter(index));
                    console.log(MyScript.showPickedLetters());

                    //this.myChar = MyScript.getLetter(index);
                    letter = "!";
                }*/
                /*onClicked: {
                    console.log("onClicked: index: ", index, myLetter.letter, myLetter.realChar)
                    console.log(MyScript.pickedLetters.has(realChar) ? "showing" : "obscured")
                    state= MyScript.pickedLetters.has(realChar) ? "showing" : "obscured"
                }*/
            }
            /*Component.onCompleted: {
                console.log("onComplete of a repeater");
                for (var i = 0; i< myRepeater.count; i++){
                     myRepeater.itemAt(i).state = Qt.binding(function() {
                         console.log("Binding ", i );
                         return MyScript.pickedLetters.has(myRepeater.itemAt(i).realChar) ? "showing" : "obscured"
                     })
                 }
            }*/
        }
    }
}
