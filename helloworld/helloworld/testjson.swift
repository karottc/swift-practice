//
//  testjson.swift
//  helloworld
//
//  Created by k on 15/7/2.
//  Copyright (c) 2015年 com.karottc. All rights reserved.
//

import Foundation

func testJson() {
    // Swift对象
    let user = [
        "uname": "user1",
        "tel": ["mobile": "138", "home": "010"]
    ]
    // 首先判断能不能转换
    if (!NSJSONSerialization.isValidJSONObject(user)) {
        println("is not a valid json object")
        return
    }
    let data : NSData! = NSJSONSerialization.dataWithJSONObject(user, options: nil, error: nil)
    var str = NSString(data:data, encoding: NSUTF8StringEncoding)
    println("JSON str:")
    println(str)
    
    var json : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
    println("Json object:")
    println(json)
    // 验证json对象可用性
    let uname : AnyObject! = json.objectForKey("uname")
    let mobile : AnyObject! = json.objectForKey("tel")!.objectForKey("mobile")
    println("get Json Object:")
    println("uname: \(uname), mobile: \(mobile)")
}