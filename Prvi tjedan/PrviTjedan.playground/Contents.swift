import UIKit

let palindrom = Palindrom()
let brojanjeIgraca = Players()
let brojanjeKarata = Cards()
let brojanjeSibica = Matches()
let vrijemePredavanja = Week1Classes()
let bankaIgra = Week1Bank()
let nizIntegera = IntSum()
let velikaSlova = Uppercase()
let lopta = Ball()

// 1.
print(palindrom.checkPalindrom(string: "ana na "))
print(palindrom.checkPalindrom(string: "sataras"))

// 2.
print(brojanjeIgraca.countN(n: 130))

// 3.
print(brojanjeKarata.countCards(n: 200))

// 4.
print(brojanjeSibica.countMatches(n: 2))

//5.
vrijemePredavanja.classAlgorithm(smallBreakLength: 10, bigBreakLength: 15, bigBreakAppointment: 3, inputTime: "5:43")

//6.
bankaIgra.playGame(bankNumber: "0434567333", account: .ziro, client: .fizicki)

//7.
nizIntegera.sumMinIntegers(array: [32, 20, 12, 5])

//8.
velikaSlova.applyUpperLowercase(string: "otorinolaringologija")

//9.
lopta.countBallAppeareances(height: 6.2, decrease: 0.66)
