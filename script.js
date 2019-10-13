// By default each import would load a new instance of the script but
// we want to share the pickedLetters across instances therefore .pragma library
.pragma library

var pickedLetters = new Set([]);

const secretWord = "OPENTECHSCHOOL"

function addLetter(letter) {
    pickedLetters.add(letter);
}

function showPickedLetters() {
    console.log("pickedLettersSet: " + Array.from(pickedLetters).join(','));
}

// returns the letter if it is a member of the pickedLetters
// or an underscore if not
function revealLetter(testChar) {
    return pickedLetters.has(testChar) ? testChar : "_";
}

function getLetter(index) {
    return revealLetter(secretWord.charAt(index))
}

function decodeWord(word) {
    var decodedWord = ''
    for(var letterIndex in word){
        decodedWord += getLetter(letterIndex);
    }
    return decodedWord;
}

