import QtQuick 2.13
import "script.js" as MyScript
import QtQuick.Controls 2.5

Rectangle {
    id: root
    width: 820; height: 370
    color: "lightblue"
    property int lives: 5
    property int newGameLives: 5
    FontLoader { id: localFont; source: "Bungee-Regular.ttf" }
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

    onLivesChanged: {
        if ( lives < 1 ) {
            state = "dead"
        }
    }

    function startGame() {
        MyScript.pickedLetters.clear();
        keyboard.reset()
        if ( MyScript.secretWords.length < 1 ) {
            root.state = "initializing";
            loadWordsFromServer();
        } else {
            MyScript.secretWord = MyScript.secretWords.shift();
            word.myWord = MyScript.secretWord;
            console.log(MyScript.secretWord);
            root.lives = root.newGameLives;
            root.state = "playing";
        }
        var resp = messageClass.doMessageChange("this is something QML provided");
        print ("in QML: received from C++: " + resp);

    }

    Word {
        id: word
        x: 10
        y:40
        visible:  root.state != "initializing"
        state: root.state
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
            root.lives--
        }
    }

    Balloons {
        id: balloons
        x: 650
        y: 10
        count: root.lives
    }

    ManInChair {
        x:690
        y:120
        state: root.state == "dead" ? "dead" : "alive"
    }

    Crocodile {
        x: 660
        Component.onCompleted: {
            root.onLivesChanged.connect(reassessState);
            root.onStateChanged.connect(reassessState);
        }
        function reassessState() {
            if ( ( root.state == "playing" && root.lives == root.newGameLives ) || root.state == "won") {
                state = "hidden";
            } else if ( root.state == "dead" ) {
                state = "feeding";
            } else {
                state = "hungry";
            }
        }
    }

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
        loadWordsFromServer();
    }

    function loadWordsFromServer() {
        //const Url = "https://www.wordgenerator.net/application/p.php?type=1&id=charades_easy&spaceflag=false";
        const Url = "http://localhost:8000/words/application/p.php?type=1&id=charades_easy&spaceflag=false";
        console.log("Attempting to load the words from the webservice at " + Url);
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if(xhr.readyState === XMLHttpRequest.DONE) {
                console.log("Got a response from the word url: " + Url);
                const response = xhr.responseText.toString();
                MyScript.secretWords = response.split(",").map(w => w.toUpperCase());
                startGame();
            }
        }
        xhr.open("GET", Url);
        xhr.send();
    }

}
