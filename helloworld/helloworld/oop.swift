//
//  oop.swift
//  helloworld
//
//  Created by k on 15/6/29.
//  Copyright (c) 2015年 com.karottc. All rights reserved.
//

import Foundation

/* version 1
class Student {
    var name:String = ""
    var classno:Int = 0
    var from:String = ""
    let country:String = "China"
}
*/
class Deposit {
    init() {
        println("output init at Deposit")
    }
}

class Person {
    var name:String!
    lazy var money:Deposit = Deposit()
}
// version 2
class Student {
    var name:String!
    var classno:Int!
    var from:String!
    let country:String = "China"
    let friend:Person = Person()
}

var student = Student()

// 计算属性
class PCalcuator {
    var a:Int = 1
    var b:Int = 1
    
    var sum:Int {
        return a + b
    }
    
    var difference:Int {
        return a - b
    }
    
    var product:Int  {
        return a * b
    }
    
    var quotient:Int {
        return a / b
    }
    
    init(a:Int, b:Int) {
        self.a = a
        self.b = b
    }
}

// 类的对象是引用类型，结构体是值类型
class People {
    var name = ""
    init(name:String) {
        self.name = name
    }
}
struct Human {
    var name = ""
    init(name:String) {
        self.name = name
    }
}

//var xw = People(name:"xw")
//println(xw.name)
//var p = xw
//p.name = "xp"
//println(xw.name)

//var lm = Human(name:"lm")
//var l = lm
//l.name = "lm"
//println(lm.name)

extension String {
    subscript(start:Int, length:Int) -> String {
        get {
            return (self as NSString).substringWithRange(NSRange(location:start, length:length))
        }
        set {
            var tmp = Array(self)
            var s = ""
            var e = ""
            for (idx, item) in enumerate(tmp) {
                if (idx < start) {
                    s += "\(item)"
                }
                if (idx > start + length) {
                    e += "\(item)"
                }
            }
            self = s + newValue + e
        }
    }
    
    subscript(index:Int) -> String {
        get {
            return String(Array(self)[index])
        }
        set {
            var tmp = Array(self)
            tmp[index] = Array(newValue)[0]
            self = ""
            for (idx, item) in enumerate(tmp) {
                self += "\(item)"
            }
        }
    }
}