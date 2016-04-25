// STRV iOS CrashCourse: Swift Language

import Foundation

// Declaring variables vs. constants

let someConstant : String = "This is a constant"
var someVariable : String = "This is a variable"

let someConstant2 = "This is a constant";
var someVariable2 = "This is a variable";
let someInt = 1;
let someFloat = 1.0;


// Strings

let string = "Hello "
let greeting = string + "World!"
for char in string.characters {
    print(char)
}

let x = 5
let y = 6
print( "\(x) x \(y) = \(x*y)")

// -- Length of String
let length = string.characters.count

// -- Get Start and End Index
let startIndex = string.startIndex
let endIndex = string.endIndex

// -- Get substring
let substring = string[startIndex..<endIndex.advancedBy(-2)]
let rangeOfel = substring.rangeOfString("el")
let rangeOfEL = substring.rangeOfString("EL", options: .CaseInsensitiveSearch)
let rangeOfNotFound = substring.rangeOfString("Not Found") // nil

// -- Regular expressions

func cutTheNumbers(input: String) -> String {
    let pattern = "(.+)\\s(\\d+):?(\\d*)"
    let regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
    let matches = regex.matchesInString(input, options: [], range: NSMakeRange(0, input.characters.count))
    if  matches.count > 0 {
        return regex.stringByReplacingMatchesInString(input, options: [], range: NSMakeRange(0, input.characters.count), withTemplate: "$1")
    }
    return input
}

cutTheNumbers("Aisle 5:44")
cutTheNumbers("Piece 5")

func validateEmail(candidate: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
}

validateEmail("tomas.srna@strv.com")
validateEmail("not.a.valid.email")

// Arrays and Dictionaries

let someArray:[String] = ["one","two","three"]
var someOtherArray:[String] = ["alpha","beta","gamma"]

let someDictionary:[String:Int] = ["one":1, "two":2, "three":3]
var someOtherDictionary:[String:Int] = ["cats":1, "dogs":4, "mice":3]

var array = ["one","two","three"]
array += ["four"]
array += ["five","six"]

var dictionary = ["cat": 2, "dog":4, "snake":8]
dictionary["lion"] = 7
// No same operator for dictionary :(
for (k, v) in ["bear":1, "mouse":6] {
    dictionary[k] = v
}


// Typed Collections

class Car {
    var speed = 0.0
    
    func accelerate(by by: Double = 1.0) -> Bool {
        speed += by
        return true
    }
}

var cars = [ Car(), Car(), Car()]

cars.append(Car())
cars[0].accelerate(by: 2.0)

for car in cars {
    car.accelerate(by: 3)
}

for car in cars {
    print("\(car.speed)")
}

// Conditionals

if 5 < 4 {
    print("5 < 4")
} else {
    print("5 >= 4")
}

let something = 5
switch something {
case 0:
    print("0")
    fallthrough
case 0..<5:
    print("1,2,3,4")
case 5...10:
    print("5,6,7,8,9,10")
default:
    break
}

// Loops

for i in 1..<10 {
    print("\(i)")
}

let someArr = ["apple","pair","peach","watermelon","strawberry"]
for fruit in someArr[2..<4] {
    print(fruit)
}

// Functions and Closures

func sayHello(name: String = "world") -> Bool {
    print("hello \(name)");
    return true;
}

sayHello()
sayHello("mike")

func sayHello2(name: String = "World") -> (success: Bool, greeting: String) {
    let greeting = "hello \(name)"
    return (true, greeting)
}

sayHello2("tomas")

func sayHello3(to name: String = "World") -> (success: Bool, greeting: String) {
    let greeting = "hello \(name)"
    return (true, greeting)
}

sayHello3(to: "tomas")

// -- Closure

let two = 2

let isEven = {
    (number: Int) -> Bool in
    let mod = number % two;
    return (mod==0);
}

func verifyIfEven(number: Int, verifier:(Int->Bool)) ->Bool {
    return verifier(number);
}

verifyIfEven(12, verifier: isEven)
verifyIfEven(19, verifier: isEven)

// -- Callbacks

func assertEven(number: Int, success: () -> (), failure: (error: NSError) -> ()) {
    if isEven(number) {
        success()
    } else {
        failure(error: NSError(domain: "com.strv.Swift", code: 2, userInfo: [NSLocalizedDescriptionKey: "The number is not even"]))
    }
}

//assertEven(2,
//           success: {
//                print("Woo-hoo, 2 is even")
//           },
//           failure: { (error) in
//                print("Error occured: \(error.localizedDecription)")
//           }
//)

// Classes & Protocols

protocol Bookable {
    func bookNumberOfRooms(room: Int) -> Bool
}

class Hotel : Bookable {
    var rooms : Int {
        return 10
    }
    var fullRooms = 0
    var description: String {
        return "Size of Hotel: \(rooms) rooms capacity:\(fullRooms)/\(rooms)"
    }
    var emptyRooms :Int {
        get {
            return rooms - fullRooms
        }
        set {
            if(newValue < rooms) {
                fullRooms = rooms - newValue
            } else {
                fullRooms = rooms
            }
        }
        
    }
    func bookNumberOfRooms(room: Int = 1) -> Bool
    {
        if(self.emptyRooms>room) {
            self.fullRooms += 1
            return true
        } else {
            return false
        }
    }
}

let h = Hotel()
h.emptyRooms = 7
h.description
h.bookNumberOfRooms(2)
h.description
h.bookNumberOfRooms()
h.description

class GrandHotel : Hotel {
    override var rooms : Int {
        return 100
    }
}

let gh = GrandHotel()
gh.emptyRooms = 77
gh.description
gh.bookNumberOfRooms(2)
gh.description
gh.bookNumberOfRooms()
gh.description

// Optionals

var someInteger : Int? = nil

if someInteger != nil {
    print("someInteger: \(someInteger!)")
} else {
    print("someInteger has no value")
}

someInteger = 4

if let sI = someInteger {
    print("someInteger: \(sI)")
}
