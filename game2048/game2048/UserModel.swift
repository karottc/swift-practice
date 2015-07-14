//
//  UserModel.swift
//  game2048
//
//  Created by k on 15/7/11.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation
import UIKit
//import SQLite3

class UserModel {
    var db:SQLiteDB!
    
    class func get_uuid() -> String {
        var userid = NSUserDefaults.standardUserDefaults().stringArrayForKey("swift2048bykarottc")
        if userid != nil {
            print("first uuid\(userid![0])")
            return userid![0]
        }
        var uuid_ref = CFUUIDCreate(nil)
        var uuid_string_ref = CFUUIDCreateString(nil, uuid_ref)
        var uuid:String = NSString(format: uuid_string_ref) as String
        NSUserDefaults.standardUserDefaults().setObject(uuid, forKey: "swift2048bykarottc")
        print("second uuid \(uuid)")
        // 不知道什么原因，现在每次生成的UUID都不一样
        uuid = "E27E608A-7DD9-4DDC-8C1D-64DEBDDDF42E"
        return uuid
    }
    
    // 初始化数据
    init(dimension:Int, maxnum:Int, backgroundColor:UIColor) {
        db = SQLiteDB.sharedInstance()
        var cicolor = CIColor(color: backgroundColor)
        var red = cicolor.red
        var green = cicolor.green
        var blue = cicolor.blue
        var alpha = cicolor.alpha
        
        var userid = UserModel.get_uuid()
        let data = db.query("SELECT *FROM userdata WHERE userid='\(userid)'")
        if data.count == 0 || data[0].data["dimension"]!.asInt() == 0 {
            var sql = "INSERT INTO userdata(userid, dimension, maxnum, red, green, blue, alpha) VALUES('\(userid)', \(dimension), \(maxnum), \(red), \(green), \(blue), \(alpha))"
            db.execute(sql)
            print(sql)
        }
    }
    
    init() {
        db = SQLiteDB.sharedInstance("data2.db")
        //db = SQLiteDB.sharedInstance()
        db.execute("CREATE table if not exists userdata(userid varchar(64) primary key, dimension integer, maxnum integer, red integer, green integer, blue integer, alpha integer)")
    }
    
    // 获得现在保存的数据
    func get_userdata() -> Dictionary<String, String> {
        var userid = UserModel.get_uuid()
        let data = db.query("SELECT *FROM userdata WHERE userid='\(userid)'")
        var row = data[0]
        var maxnum:Int = row["maxnum"]!.asInt()
        var dimension:Int = row["dimension"]!.asInt()
        var red:Double = row["red"]!.asDouble()
        var green:Double = row["green"]!.asDouble()
        var blue:Double = row["green"]!.asDouble()
        var alpha:Double = row["alpha"]!.asDouble()
        
        var dic:Dictionary<String, String> = [
            "maxnum": "\(maxnum)",
            "dimension": "\(dimension)",
            "red": "\(red)",
            "green": "\(green)",
            "blue": "\(blue)",
            "alpha": "\(alpha)"
        ]
        return dic
    }
    
    // 保存维度数据
    func save_dimension(dimension:Int) {
        let userid = UserModel.get_uuid()
        db.execute("UPDATE userdata SET dimension=\(dimension) WHERE userid='\(userid)'")
    }
    
    // 保存过关数据
    func save_maxnum(maxnum:Int) {
        let userid = UserModel.get_uuid()
        db.execute("UPDATE userdata SET dimension=\(maxnum) WHERE userid='\(userid)'")
    }
    
    // 保存颜色数据
    func save_color(backgroundColor: UIColor) {
        var cicolor = CIColor(color: backgroundColor)
        var red = cicolor.red
        var green = cicolor.green
        var blue = cicolor.blue
        var alpha = cicolor.alpha
        var userid = UserModel.get_uuid()
        
        db.execute("UPDATE userdata SET red=\(red), green=\(green), blue=\(blue), alpha=\(alpha) WHERE userid='\(userid)'")
    }
    
    deinit {
        //db.closeDatabase()
    }
}