# Hangman Game written in QML

![Screenshot](http://richardeigenmann.github.io/HangmanQml/screenshot.png)

## How to run it

Ensure you have QML installed. You need to know where the qmlscene program resides.

```bash
cd \your\directory\HangmanQml
qmlscene Game.qml
```

## Motivation: Learn QML and QT

QML is an interesting extension to the QT C++ framework. It is a delarative language
that allows you to very quickly create screens. The language integrates with signals and
slots and a full fledged JavaScript interpreter which gives it the ability to do a lot
of things. Its attractiveness is that you can quickly iterate through various designs.
The heavy lifting and runtime critical processing can be delegated to C++ which can then
interact with the QML GUI.

Since you only learn by doing a real project, here is a Hangman game that loads a
list of words from a webservice and lets you try your skill at guessing. For a wrong
letter you lose a balloon and when no more balloons are left, the poor man in his chair
is fed to the ravenous crocodile. The entire game is done in QML and JavaScript and doesn't
interact with C++.

I used this free online book to learn QML and recommend it highly: <http://qmlbook.github.io/index.html>

## Clever things

### Using state for the Letter

The widgets in QML have a state which is a powerful concept as we can attach property
changes to a state and can animate the property changes in a transition. The Letter.qml
has a state "obscured" and a state "showing". Depending on the state the text of the letter
is either an underscore or the actual character.

This is independent of the context in which the letter is being used. In the keyboard after
picking a letter it becomes obscured while in the secret word it is obscured until the right
letter has been picked in which case it is revealed. This logic is delegated to the component
instantiating the letter.

The Crocodile.qml also shows state transitions on the y-axis.

```JavaScript
states: [
    State {
        name: "obscured";
        PropertyChanges { target: myChar; text: '_' }
    },
    State {
        name: "showing";
        PropertyChanges { target: myChar; text: root.realChar }
    }
]
```

### Using signals to communicate the picked letter

The Letter.qml declares a MouseArea and a onClicked handler. This fires the
signal clicked on the Letter object to which the instantiation object than then
listen and take action.

```JavaScript
signal clicked(string clickedChar)

MouseArea {
    anchors.fill: parent
    onClicked: root.clicked(root.realChar)
}
```

### Using a static JavaScript to carry state from one item to the next

I use a JavaScript array for the secreWords that come from the webservice and a
JavaScript Set for the pickedLetters. Oddly when you import a JavaScript file into a
QML object it creates a new instance of this in memory which is not desired. I would
rather have a "static" instance of the library. This is achieved with the somewhat
obscure .pragma library instruction at the top of the script.js file.

```JavaScript
.pragma library

var pickedLetters = new Set([]);

var secretWord = "OPENTECHSCHOOL"

var secretWords = [];
```

### Using a repeater to create the keyboard

A Repeater with a "model" of 26 instances is used create the alphabet. The letters
are the delegate to the model and are laid out in a Grid.

### Using a connected signal to refresh the word

The signal refresh on the word object is used to trigger the refresh of the individual
letters in the word. This is achieved by waiting till the child objects of the repeater
have been created Component.onCompleted and then using the connect function to bind
the reassessState function on the delegate to the refresh signal on the word.

```JavaScript
Component.onCompleted: {
    root.refresh.connect(reassessState)
}
function reassessState() {
    state= MyScript.pickedLetters.has(realChar) ? "showing" : "obscured"
}
```

### Using a string property for the word

The Word object is a Repeater based on a model. By choosing a string property as the
model for the Repeater we can have the repeater update the number of characters it
shows when the model changes.

### The color of the balloons

Note that the color is set based on the index value. Since we might be creating more
balloons than there are colors in the colors array we use the modulo function to
divide the index by the number of colors and use the remainder from this division to
pick the color. Thus we will never ask for a color that is outside of the color array.


### Laying out the balloons

Since we don't know up front how many balloons will be holding up the
man in the chair we need to generate the balloons dynamically and lay
them out in an attractive fashion. For this we use a number model and bind it to
the count property. This way if the model is changed the PathView will add or remove the
balloons as needed.

QML gives us the Path object and has
a number of [PathElements](https://doc.qt.io/qt-5/qml-qtquick-path.html#pathElements-prop)
along which it can lay out the n Balloon shapes that it's "delegate"
will create.

```
path: Path {
    startX: 40; startY: 35
    PathQuad { x: 140; y: 40; controlX: 80; controlY: 95 }
    PathQuad { x: 20; y: 50; controlX: 80; controlY: 5 }
}
```

### Loading the words from a webservice

This is actually well explained in the QML Book. See <https://qmlbook.github.io/ch12-networking/networking.html>

Here is the reasonably common code:

```JavaScript
function loadWordsFromServer() {
    const Url = "https://www.wordgenerator.net/application/p.php?type=1&id=charades_easy&spaceflag=false";
    console.log("Attempting to load the words from the webservice at " + Url);
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if(xhr.readyState === XMLHttpRequest.DONE) {
            const response = xhr.responseText.toString();
            MyScript.secretWords = response.split(",").map(w => w.toUpperCase());
            startGame();
        }
    }
    xhr.open("GET", Url);
    xhr.send();
}
```


## To Explore

* How to test? Unit tests? GUI tests?
* How to package for Desktop, RPM, Android
* Interacting with C++

## Sources

Man on Chair found here: <http://www.clker.com/clipart-735475.html> The website claims Free Clipart instead of a license.

Crocodile was found here: <http://www.clker.com/clipart-crocidile.html>  The website claims Free Clipart instead of a license.

Water found here: <http://www.clker.com/clipart-14950.html> The website claims Free Clipart instead of a license.

Bungee Font by David Jonathan Ross licensed OFL available on Goolge Fonts <https://fonts.google.com/specimen/Bungee?selection.family=Bungee> or <https://www.1001freefonts.com/bfonts153.php>

The list of words is retrieved from <https://www.wordgenerator.net/pictionary-word-generator.php>

Drawing the balloons was adapted from <https://www.loganfranken.com/blog/64/html5-canvas-balloon/>
