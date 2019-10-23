import QtQuick 2.13
import "script.js" as MyScript
import QtQuick.Controls 2.5

Rectangle {
    id: root
    width: 820; height: 370
    color: "lightblue"
    state: "initializing"

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

    FontLoader { id: localFont; source: "Bungee-Regular.ttf" }

    Word {
        id: word
        x: 10
        y:40
        visible: root.state == "playing" || root.state == "won" || root.state == "dead"
    }

    Keyboard {
        id: keyboard
        x: 20
        y: 160
        onPicked: handleLetterPicked(pickedChar)
        visible: root.state == "playing"
    }
    
    function handleLetterPicked(pickedChar) {
        MyScript.addLetter(pickedChar)
        if ( MyScript.winnerChar(pickedChar) ) {
            word.refresh()
            if ( MyScript.allRevealed() ) {
                root.state = "won"
            }
        } else {
            balloons.burstOne()
        }
    }

    Balloons {
        id: balloons
        x: 650;
        y: 10
        onDie: {
            root.state = "dead"
        }
    }

    Crocodile { x: 660; y:250 }

    Image { x:580; y: 170; width: 240; height: 200; source: "water.svg" }

    Text {
        id: gameOver
        visible: root.state == "dead"
        x: 200
        y: 100
        text: "Game Over!"
        font.family: "Bungee"
        color: "#303030"
        font.pointSize: 30;
    }

    Text {
        id: gameWon
        visible: root.state == "won"
        x: 200
        y: 100
        text: "You Win!"
        font.family: "Bungee"
        color: "#303030"
        font.pointSize: 30;
    }

    Text {
        id: loading
        visible: root.state == "initializing"
        x: 200
        y: 100
        text: "Loading..."
        font.family: "Bungee"
        color: "#303030"
        font.pointSize: 30;
    }


    Button {
        text: "New Game"
        x: 260
        y: 200
        visible: root.state == "won" || root.state == "dead"
        onClicked: {
            startGame();
        }
    }

    Component.onCompleted: {
        console.log("Now load the words from the webservice");
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                const response = xhr.responseText.toString();
                MyScript.secretWords = response.split(",").map(w => w.toUpperCase());
                startGame();
            }
        }
        xhr.open("GET", "https://www.wordgenerator.net/application/p.php?type=1&id=charades_easy&spaceflag=false");
        xhr.send();
    }

    function startGame() {
        MyScript.showPickedLetters();
        MyScript.pickedLetters.clear();
        console.log("clear");
        MyScript.showPickedLetters();
        keyboard.reset()
        MyScript.secretWord = MyScript.secretWords.shift();
        word.myWord = MyScript.secretWord;
        console.log(MyScript.secretWord);
        //balloons.count = MyScript.secretWord.length;
        balloons.state = "alive"
        balloons.count = 10;
        balloons.createBalloons();
        root.state = "playing";

    }
}
