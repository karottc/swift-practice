//
//  main.swift
//  helloworld
//
//  Created by k on 15/6/28.
//  Copyright (c) 2015年 com.karottc. All rights reserved.
//

import Foundation

println("Hello, World!");


var str:String="hello, world!!"

//str = 1024

let Constr = "I love my xxx"

//Constr = "2014"

//var tmpCount:Int32=2.8

println(Constr)

println(Int.min)
println(Int.max)
println(Int64.max)    // Int = Int64
println(UInt.max)

typealias Float32 = Float
typealias Float64 = Double

var sampleBool:Bool = false
println(sampleBool.description)

let gameName = "2048"
println("hell my program name is \(gameName)")

let logTitle = "Swift is a new object-oriented programming. 加个中文呢"  // 中文和英文长度一样
println("LogTitle has \(count(logTitle)) characters")

// 可选类型，？这个符号来标明
var roundValue:Int?
println("The round value is \(roundValue?.description)")
// 也可以用关键字显示指定
var optionValue:Optional<Int>
if var MaxValue = optionValue {
    MaxValue += 1
    println("The convert Value is \(MaxValue)")
}
//println("This should be error \(optionValue!)")  // ! 表示强制获取值

var succedCreateClass:Int?=2
var feedBack = 1
var returnValue=succedCreateClass ?? feedBack
println("This return value is \(returnValue)")

// 元组初始化
let myProject = (oneElementL:"game", towElement:2048)

func getPrime(value:Int)->Bool {
    var isPrime = true
    assert(value<=0, "error")   // 似乎在release版，这个语句就无效了
    
    for var index=2; index<value; index++ {
        if (value%index) == 0 {
            isPrime = false
        }
    }
    return isPrime
}

var oneBit:Int8 = 0b1111100
var twoBit = oneBit>>2
println(twoBit)


// 创建数组
var emptyArray = [String]()
var ExceptionTypes = ["none", "warning", "error"] // 省略类型声明数组
ExceptionTypes[0] = "it's safy"   // 修改数组中的元素
//ExceptionTypes[3] = "gron"   // 数组越界.
println(ExceptionTypes)
// 二维数组
var mutlArray = Array<Array<Int> >()
var intArray = [1,2,3]
mutlArray.append(intArray)
mutlArray.append(intArray)
mutlArray[1][1] = 5
println(mutlArray)

// 声明字典
var myDict = Dictionary<String, String>()
myDict = ["apptype":"2dgame", "name":"2048"]
println(myDict)

// 结构体
struct BookInfo {
    var ID:Int=0
    var Name:String="Default"
    var Author:String="Default"
}

var BeautyMath=BookInfo(ID:0021, Name:"The Beauty Math", Author:"Junmu")
BeautyMath.Name = "Jun Wu"
println(BeautyMath)

// 枚举类型
/*
enum enumeration name {
    case enumeration case 1
    case enumeration case 2 (associated value types)
}
*/
enum PointRect {
    case top(Int, Int)
    case bottom(Int, Int)
    case left(Double, Double)
    case right(Double, Double)
}
var samplePoint=PointRect.top(10, 5)
println(samplePoint)

// switch语句
var weekDay = 3
switch weekDay {
case 1,2,3,4,5:
    println("work day")
case 5,6:
    println("weekend.")
default:
    println("input error")
}
// 值绑定
var anotherPoint = (2, 0)
switch anotherPoint {
case (var x, 0):
    x--
    println("\(x) on the x-axis")
case (0, var y):
    y++
    println("\(y) on the y-axis")
case let (x, y) where x == y:
    println("(\(x), \(y)) is on the line x == y")
case let (x, y):
    println("point at (\(x), \(y))")
}

// 元组作为函数的返回值
func SetFormEnable(bEnable:Bool) -> (Int, Bool) {
    var FormxPosion = 0
    var isEnable = true
    return (FormxPosion, isEnable)
}