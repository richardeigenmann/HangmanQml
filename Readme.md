# Hangman Game written in QML

## How to run it

Ensure you have QML installed

```bash
cd \your\directory\HangmanQml
qmlscene Game.qml
```

## ToDo

* use state on the game for won or lost
* stop accepting input on endgame state
* draw lines from ballons to a knot
* burst the ballons


## Learn QML and QT

See <http://qmlbook.github.io/index.html>

## Clever things

### Using state for the Letter

### Using signals to communicate the picked letter

### Using a static JavaScript to carry state from one item to the next

### Using a repeater to create the keyboard

### Using a connected signal to refresh the word

### Laying out the balloons

Since we don't know up front how many balloons will be holding up the
man in the chair we need to generate the balloons dynamically and lay
them out in an attractive fashion. QML gives us the Path object and has
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



## To Explore

* How to test? Unit tests? GUI tests?
* How to package for Desktop, RPM, Android
* Interacting with C++

## Sources

Man on Chair found here: <http://www.clker.com/clipart-735475.html> The website claims Free Clipart instead of a license.

Crocodile was found here: <http://www.clker.com/clipart-crocidile.html>  The website claims Free Clipart instead of a license.

Water found here: <http://www.clker.com/clipart-14950.html> The website claims Free Clipart instead of a license.

Bungee Font by David Jonathan Ross licensed OFL available on Goolge Fonts <https://fonts.google.com/specimen/Bungee?selection.family=Bungee> or <https://www.1001freefonts.com/bfonts153.php>

