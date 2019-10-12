import QtQuick 2.13
import "script.js" as MyScript

Rectangle {
    id: root
    width: 820; height: 370
    color: "lightblue"

    FontLoader { id: localFont; source: "Bungee-Regular.ttf" }

    Text {
        id: solution
        text: MyScript.decodeWord(MyScript.secretWord)
        y: 30
        anchors.horizontalCenter: root.horizontalCenter
        font.pointSize: 30; font.bold: true

        MouseArea { id: mouseArea; anchors.fill: parent }
    }
    
    Keyboard {
        x: 20
        y: 100
        onPicked: handleLetterPicked(pickedChar)
    }
    
    function handleLetterPicked(pickedChar) {
        MyScript.addLetter(pickedChar)
        const result = MyScript.decodeWord(MyScript.secretWord);
        solution.text = MyScript.decodeWord(result)
    }

    Balloons { x: 650; y: 10 }
 
    Crocodile { x: 660; y:250 }

    Image { x:580; y: 170; width: 240; height: 200; source: "water.svg" }
}
