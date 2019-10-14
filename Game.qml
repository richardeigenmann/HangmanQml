import QtQuick 2.13
import "script.js" as MyScript

Rectangle {
    id: root
    width: 820; height: 370
    color: "lightblue"

    FontLoader { id: localFont; source: "Bungee-Regular.ttf" }

    Word {
        id: word
        x: 10
        y:40
    }

    Keyboard {
        x: 20
        y: 160
        onPicked: handleLetterPicked(pickedChar)
    }
    
    function handleLetterPicked(pickedChar) {
        MyScript.addLetter(pickedChar)
        if ( MyScript.winnerChar(pickedChar) ) {
            word.refresh()
            if ( MyScript.allRevealed() ) {
                gameWon.visible = true
            }
        } else {
            balloons.burstOne()
        }
    }

    Balloons {
        id: balloons
        x: 650;
        y: 10
        count: 5
        onDie: {
            gameOver.visible = true;
        }
    }
 
    Crocodile { x: 660; y:250 }

    Image { x:580; y: 170; width: 240; height: 200; source: "water.svg" }

    Text {
        id: gameOver
        visible: false
        x: 200
        y: 100
        text: "Game Over!"
        font.family: "Bungee"
        color: "#303030"
        font.pointSize: 30;
    }

    Text {
        id: gameWon
        visible: false
        x: 200
        y: 100
        text: "You Win!"
        font.family: "Bungee"
        color: "#303030"
        font.pointSize: 30;
    }
}
