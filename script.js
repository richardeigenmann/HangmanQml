var pickedLetters = new Set([]);

const secretWord = "OPENTECHSCHOOL"

function addLetter(letter) {
    pickedLetters.add(letter);
}

function showPickedLetters() {
    pickedLetters.forEach(x => console.log(x));
}

function decodeWord(word) {
    var decodedWord = ''
    var missingCount = 0;
    for(var letterIndex in word){
        if ( pickedLetters.has(word[letterIndex]) ) {
            decodedWord += word[letterIndex];
        } else {
            decodedWord += '_';
            missingCount++;
        }
    }
    return decodedWord;
}