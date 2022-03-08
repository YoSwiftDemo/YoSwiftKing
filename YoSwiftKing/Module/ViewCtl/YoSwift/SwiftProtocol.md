# Protocol
##  协议定义
> 协议可以用来定义方法、属性、下标的声明，协议可以被枚举、结构体、类遵守(多个协议之间用逗号隔开)
- 协议中定义方法时不能有默认值
- 默认情况下，协议中定义的内容必须全部都实现

```
protocol Drawable{
    func draw()
    var x: Int{get set}
    var y: Int{get}
    subscript(index: Int) -> Int{get set}
}
protocol Test1 { }
protocol Test2 { }
protocol Test3 { }
class TestClass: Test1,Test2,Test3 { }

```
## 协议中的属性
- 协议中定义属性时必须用var关键字
- 实现协议时的属性权限要不小于协议中定义的属性权限
- 协议定义get、set，用var存储属性或get、set计算属性去实现
- 协议定义get，用任何属性都可以实现

```
protocol Drawable{
    func draw()
    var x: Int{get set}
    var y: Int{get}
    subscript(index: Int) -> Int{get set}
}

class Person: Drawable{
    var x: Int = 0
    var y: Int = 0
    func draw() {
        print("begin drawing")
    }
    subscript(index: Int) -> Int {
        set {}
        get {index}
    }
}

class Person1: Drawable{
    var x: Int {
        get {0}
        set {}
    }
    var y: Int {0}
    subscript(index: Int) -> Int {
        get {
            index
        }
        set {
            
        }
    }
    func draw() {
        print("begin drawing")
    }
}

```
## 类型方法、类型属性

> 为了保证通用，协议中必须用static定义类型方法、类型属性、类型下标

```
protocol Drawable{
    static var pencil: Int{get set}
    static func draw()
}

class Person1: Drawable{
    static var pencil: Int = 1
    static func draw() {
        print("draw")
    }
}

class Person2: Drawable{
    static var pencil: Int = 2
    class func draw() {
        print("draw")
    }
}
```

## mutating
>只有将协议中的实例方法标记为mutating,才允许结构体、枚举的具体实现修改自身内存；类在实现方法时不用加mutating，枚举和结构体才需要加mutating
```
protocol Drawable{
    mutating func draw()
}

class Person: Drawable{
    var age = 20
    func draw() {
        age += 1
    }
}

struct Point: Drawable{
    var x: Int = 0
    mutating func draw() {
        x += 10
    }
}

```
## init
>协议中还可以定义初始化器init，非final类实现时必须加上required

```
protocol Drawable{
    init(x: Int,y: Int)
}

class Point: Drawable{
    required init(x: Int, y: Int) {
        
    }
}

final class Size: Drawable{
    init(x: Int, y: Int) {
        
    }
}

```
> 如果从协议实现的初始化器，刚好是重写了父类的指定初始化器，那么这个初始化必须同时加required、override

```
protocol Livable{
    init(age: Int)
}
class Person {
    init(age: Int){ }
}
class Student: Person,Livable {
    required override init(age: Int) {
        super.init(age: age)
    }
}

```
##  init、init?、init!
> 协议中定义的init?、init!，可以用init、init?、init!去实现
> 协议中定义的init，可以用init、init!去实现

```
protocol Livable{
    init()
    init?(age: Int)
    init!(no: Int)
}
class Person: Livable {
    required init() { }
    //也可以下方这样实现
//    required init() { }
    
    required init?(age: Int) { }
    //也可以如下方两种实现
//    required init!(age: Int) { }
//    required init(age: Int) { }
    
    required init!(no: Int) { }
    //也可以如下方两种实现
//    required init?(no: Int) { }
//    required init(no: Int) { }
}
```
## 协议组合

> 使用协议组合的时候，相互之间用&来分隔，其中可以包含一个类类型(最多一个)

```
protocol Livable { }
protocol Runnable { }
class Person { }
//接收Person或者其子类的实例
func fn0(obj: Person) { }
//接收遵守Livable协议的实例
func fn1(obj: Livable) { }
//接收同时遵守Livable、Runnable协议的实例
func fn2(obj: Livable & Runnable) { }
//接收同时遵守Livable、Runnable协议、并且是Person或者其子类的实例
func fn3(obj: Livable & Runnable & Person) { }

//可以定义一个别名来用
typealias RealPerson = Livable & Runnable & Person
func fn4(obj: RealPerson) { }

```
## CaseIterable
> 让枚举遵守CaseIterable协议，可以实现遍历枚举值

```
enum Season{
    case spring,summer,autumn,winter
}
extension Season: CaseIterable{
    
}

let allSeasons = Season.allCases
print(allSeasons.count) // 4
for season in allSeasons {
    print(season)
}
//spring
//summer
//autumn
//winter
```
## CustomStringConvertible
> 遵守CustomStringConvertible协议，可以自定义实例的打印字符串

```
class Person: CustomStringConvertible{
    var age: Int = 14
    var name: String = "Tom"
    var description: String{
        "name = \(name), age = \(age)"
    }
}
var p = Person()
print(p)//name = Tom, age = 14

```
## Any、AnyObject
> Swift提供了两种特殊的类型：Any、AnyObject

-  Any：可以代表任意类型(枚举、结构体、类，也包括函数类型)
-  AnyObject：可以代表任意类类型(在协议后面写上AnyObject代表只有类能遵守这个协议)

```
var obj: Any = 10
obj = "Jack"
obj = NSObject()

var data = [Any]()
data.append(1)
data.append(3.2)
data.append(NSObject())
data.append("Tom")
data.append({10})
```

## is、as?、as!、as

- is用来判断是否为某种类型，as用来做强制类型转换

```
protocol Driveable {
    func drive()
}

class Person {
    func eat() {
        print(#function)
    }
}

class Driver: Person,Driveable{
    func drive() {
        print("drive")
    }
}

var d: Any = 10
print(d is Int)//true
d = "hello"
print(d is String)//true
d = Driver()
print(d is Person)//true
print(d is Driver)//true
print(d is Driveable)//true

d = 10
(d as? Driver)?.eat() //没有调用eat方法
d = Driver()
(d as? Driver)?.eat() //调用了eat 打印为：eat()
(d as! Driver).eat() //调用了eat 打印为：eat()
(d as? Driveable)?.drive()//调用了drive，打印为drive
```

## X.self、X.Type、AnyClass

- X.self是一个元类型(metadata)的指针，metadata存放着类型相关信息
- X.self属于X.Type类型

```
protocol Driveable {
    func drive()
}

class Person {
    func eat() {
        print(#function)
    }
}

class Driver: Person,Driveable{
    func drive() {
        print("drive")
    }
}

var perType: Person.Type = Person.self
var driType: Driver.Type = Driver.self
var driableType: Driveable.Protocol = Driveable.self

var anyType: AnyObject.Type = Person.self
anyType = Driver.self

public typealias AnyClass = AnyObject.Type
var anyType2: AnyClass = Person.self
anyType2 = Driver.self

var per = Person()
perType = type(of: per)
print(Person.self == type(of: per))//true

```
> 可以根据元类型批量操作

```
class Animal {
    var age: Int = 0
    required init(){
        
    }
}
class Cat: Animal { }
class Dog: Animal { }
class Pig: Animal { }

func create(_ clses: [Animal.Type]) -> [Animal] {
    var arr = [Animal]()
    for cls in clses {
        arr.append(cls.init())
    }
    return arr
}
```

> 查看下内存占用与父类指向

```
class Person{
    var age: Int = 0
}
class Student: Person {
    var no: Int = 0
}

print(class_getInstanceSize(Student.self))//32
print(class_getSuperclass(Student.self)!)//Person
print(class_getSuperclass(Person.self)!)//_TtCs_SwiftObject
//从结果可以看出，Swift的类有个隐藏的基类的
```
## Self
> Self一般用作返回值类型，限定返回值跟方法调用者必须是同一类型(也可以作为参数类型)

```
protocol Driveable{
    func drive() -> Self
}

class Person: Driveable{
    required init() { }
    func drive() -> Self {
        type(of: self).init()
    }
}
class Student: Person { }

var p = Person()
print(p.drive())//Person

var s = Student()
print(s.drive())//Student

```
