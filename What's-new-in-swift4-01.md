
##单边range
```swift
let letters = ["a","b","c","d"]
let numberedLetters = zip(1..., letters)
print(Array(numberedLetters))
```

集合下标

```swift
let numbers = [1,2,3,4,5,6,7]
print(numbers[5...])  // 6,7
```

模式匹配

```swift
let value = 5
switch value {
case 1...:
  print("greater than zero")
case 0:
  print("zero")
case ..<0:
  print("less than zero")
default:
  fatalError("unreachable")
}
```

## String
多行文本
```swift
let multilineString = """
This is a multi-line string.
You don't have to escape "quotes" in here.
String interpolation works as expected: 2 + 3 = \(2 + 3)
The position of the closing delimiter
controls whitespace stripping.
"""
print(multilineString)
print("-----------")
```

```swift
let escapedNewline = """
To omit a line break, \
add a backslash at the end of a line.
"""
print(escapedNewline) // 这样就可以只打印一行了
print("-----------")
```

String变为一个集合

```swift
let greeting = "Hello, 😜!"
// No need to drill down to .characters
greeting.count
for char in greeting {
  print(char)
}
print("---")
```

引入`SubString` 都实现`StringProtocol` , 所以String大多API在SubString中都可以适用

```swift
let comma = greeting.index(of:",")!
let substring = greeting[..<comma]
type(of: substring)
print(substring.uppercased())
```

我们自己写的一些APIs最好把参数设置为 `StringProtocol`

#### Unicode 9

```swift
"👧🏽".count
"👨‍👩‍👧‍👦".count
"👱🏾\u{200D}👩🏽\u{200D}👧🏿\u{200D}👦🏻".count
print("👱🏾\u{200D}👩🏽\u{200D}👧🏿\u{200D}👦🏻")
"🇨🇺🇬🇫🇱🇨".count
```

获取字符的unicode

```swift
let c: Character = "🇨🇳"
print(Array(c.unicodeScalars))
```

Range<String.Index> 和 NSRange之间的转换

```swift
let string = "Hello 👩🏽‍🌾👨🏼‍🚒💃🏾"
let index = string.index(of: "👩🏽‍🌾")!
let range = index...
```

Range<String.Index>  转换为 NSRange

```swift
import Foundation

let nsRange = NSRange(range,in: string)
nsRange.length // 18 length in UTF-16 code unit
string[range].count // 3  字符的length
assert(nsRange.length == string[range].utf16.count)

// 使用 NSRange 处理 属性字
import UIKit

let formatted = NSMutableAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 14)])
formatted.addAttributes([.font : UIFont.systemFont(ofSize: 48)], range: nsRange)

// NSAttributedString APIs return NSRange
let lastCharacterIndex = string.index(before: string.endIndex)
let lastCharacterNSRange = NSRange(lastCharacterIndex..., in: string)
var attributesNSRange = NSRange()
_ = formatted.attributes(at: lastCharacterNSRange.location, longestEffectiveRange: &attributesNSRange, in: nsRange)
attributesNSRange

//  NSRange -> Range<String.Index>

let attributesRange = Range(attributesNSRange, in: string)!
string[attributesRange]
```

private 声明的变量在同一个文件中的Extension中可用

```swift
struct SortedArray<Element: Comparable> {
  private var storage: [Element] = []
  init(unsorted: [Element]) {
    storage = unsorted.sorted()
  }
}

extension SortedArray {
  mutating func insert(_ element: Element) {
    // storage is visible here
    storage.append(element)
    storage.sort()
  }
}

let array = SortedArray(unsorted: [3,1,2])
```

key paths

```swift
struct Person {
  var name: String
}
struct Book {
  var title: String
  var authors: [Person]
  var primaryAuthor: Person {
    return authors.first!
  }
}

let abelson = Person(name: "sw--")
let sussman = Person(name: "awk")

let book = Book(title: "Structure and Interpretation of Computer Programs", authors: [abelson, sussman])
```

已反斜线开头

```swift
book[keyPath:\Book.primaryAuthor.name]  // sw--
```

key paths 也是一个对象 可以存储在变量中

```swift
let authorKeyPath = \Book.primaryAuthor
type(of: authorKeyPath) // xpr_231.Book, __lldb_expr_231.Person>.Type
let nameKeyPath = authorKeyPath.appending(path: \.name)
book[keyPath: nameKeyPath] // sw--
```

类型安全的kvo (kvo 依赖Objective-C runtime ，所以只有在NSObject子类中才起作用而且任何可观察的属性必须声明为 `@objc dynamic` )

```swift
class Child: NSObject{
  let name: String
  
  @objc dynamic var age: Int
  init(name: String, age: Int) {
    self.name = name
    self.age = age
    super.init()
  }
  
  func celebrateBirthday() {
    age += 1
  }
}
```


这个改变很 cool

```swift
let mia = Child(name: "Mia", age: 5)
let observation = mia.observe(\.age) { (child, change) in
  if let oldValue = change.oldValue {
     print("\(child.name)’s age changed from \(oldValue) to \(child.age)")
  }else{
     print("\(child.name)’s age is now \(child.age)")
  }
}

mia.celebrateBirthday()
mia.celebrateBirthday()

// 注销
observation.invalidate()
// 这个将不会被监听到
mia.celebrateBirthday()
```

## 归档和序列化

>定义了一种针对任何swift type（classes, structs, and enums）进行归档和序列化的方法， 实现 `Codable` 协议，大多数情况我们只需要实现次协议什么都不需要做，当然也可以override默认的方法自定义 encode和decode

```swift
// 自定义一个类型 实现codable
struct Card: Codable,Equatable {
  
  enum Suit: String,Codable {
    case clubs, spades, hearts, diamonds
  }
  
  enum Rank: Int,Codable {
    case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
  }
  
  var suit: Suit
  var rank: Rank
  
  static func == (lhs: Card,rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
  }
}

let hand = [Card(suit: .clubs, rank: .ace), Card(suit: .hearts, rank: .queen)]
```

#### Encoding

JSONEncoder PropertyListEncoder   NSKeyedArchiver依然会支持所有Codable类型。

```swift
var encoder = JSONEncoder()
// 一下是一些可选的属性
encoder.outputFormatting = [.prettyPrinted]
encoder.dataEncodingStrategy
encoder.dateEncodingStrategy
encoder.nonConformingFloatEncodingStrategy
encoder.userInfo

// encode
let jsonData = try encoder.encode(hand)
print(String(data: jsonData, encoding: .utf8))
```

#### Decoding

```swift
let decoder = JSONDecoder()
let decodedHand = try decoder.decode([Card].self, from: jsonData)
type(of: decodedHand)
assert(decodedHand == hand)
```