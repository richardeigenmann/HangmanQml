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

### Creating the balloons

As described in the QML book in the chapter [The ObjectModel](http://qmlbook.github.io/ch07-modelview/modelview.html#the-objectmodel)
it is possible to create an ObjectModel which can then be laid out in a View
directly. The clever thing about the ObjectModel is that you can programatically
add objects to it and can later modify them programatically again.

Here is the code that creates the balloons:

```javascript
Component.onCompleted: {
    [...Array(count)].forEach(( _, index) => {
        var component = Qt.createComponent("Balloon.qml");
        balloonModel.append(component.createObject(root, {color: balloonColors[index % balloonColors.length]}));
    });
}
```

The ...Array(count).forEach is a clever way to do a Python range function. We get an
index number and enter a fat-arrow block for each index number. There we create
a component from the QML file. From the component we then create a balloon instance.
Note that the color is set based on the index value. Since we might be creating more
balloons than there are colors in the colors array we use the modulo function to
divide the index by the number of colors and use the remainder from this division to
pick the color. Thus we will never ask for a color that is outside of the color array.

```javascript
function burstOne() {
    count--;
    balloonModel.get(count).state= "deflated";
    if ( count < 1 ) {
        die();
    }
}
```

The function burstOne decrements the count of active balloons. Since the count
variable conveniently points to the last undeflated balloon in our baloon ObjectModel
we can use that to change the state of this balloon to "deflated". As this is
a state change the Balloon's transition changer kicks in which makes a nice animation
of shrinking the balloon. If we have no more balloons left, the die function is called,
which changes the state of the Balloons object which in turn creates the animation
of the man on chair falling towards our ravenous crocodile.

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

