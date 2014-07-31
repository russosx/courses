
var optionalString: String?
optionalString == nil

//var mustbeString: String
//mustbeString = nil

// Conditions

var optionalName: String?
var greeting = "Hello"
if let name = optionalName {
   greeting = "Hello, \(name)"
} else {
    greeting = "Hello, noname"
}

let vegetable = "red pepper"
switch vegetable {
case "celery":
    let vegetableComment = "Add some raisins and make ants on a log."
case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper"):
    let vegetableComment = "Is it a spicy \(x)?"
default:
    let vegetableComment = "Everything tastes good in soup."
}

// Loops

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
var largestKind: String?
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestKind = kind
        }
    }
}
largest
largestKind

var firstForLoop = 0
for i in 0..<3 {
    firstForLoop += i
}
firstForLoop

var secondForLoop = 0
for var i = 0; i < 3; ++i {
    secondForLoop += 1
}
secondForLoop

// Functions

func getGasPrices() -> (Double, Double, Double) {
    return (3.59, 3.69, 3.79)
}
getGasPrices()

func sumOf(numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(42, 597, 12)

func avgOf(numbers: Int...) -> Float {
    var sum: Float = 0
    if numbers.count == 0 {
        return sum
    }
    for number in numbers {
        sum += Float(number)
    }
    return sum/Float(numbers.count)
}
avgOf()
avgOf(42, 597, 12, 1, 234)

func returnFifteen() -> Int {
    var y = 10
    func add() {
        func addFive() {
            y += 5
        }
        addFive()
    }
    add()
    return y
}
returnFifteen()

func makeIncrementer() -> (Int -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

// Functional programming

func hasAnyMatches(list: [Int], condition: Int -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}
func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatches(numbers, lessThanTen)

// Closures

numbers.map({
    (number: Int) -> Int in
    let result = 3 * number
    return result
})

numbers.map({
    (number: Int) -> Int in
    if number % 2 == 1 {
        return 0
    } else {
        return number
    }
})

let map1 = numbers.map({number in 3 * number})
map1

//let sort1 = sort([1, 5, 3, 12, 2]) { $0 > $1 }
//sort1

import UIKit
import Foundation

