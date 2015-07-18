//
//  urldata.swift
//  testURL
//
//  Created by k on 15/7/17.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation

class URLData: NSObject, NSURLConnectionDataDelegate {
    
    var strResult:String = ""
    var flag:Bool = false
    var id:Int = 0
    
    func getHomeList() {
        //let urlString:String = "http://104.128.85.9:8001/api/gethomelist"
        //let url:NSURL = NSURL(fileURLWithPath: urlString, isDirectory: false)
        let url = NSURL(scheme: "http", host: "104.128.85.9:8001", path: "/api/gethomelist")
        //let url:NSURLComponents = NSURLComponents(string: urlString)
        //url.
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        let conn = NSURLConnection(request: request, delegate: self)
        conn!.start()
        print(conn)
    }
    
    //func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
    //    print("success 1")
    //    print(response)
    //}
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        print("success 2")
        let datastring = NSString(data: data, encoding: NSUTF8StringEncoding)
        print(datastring)
    }
    
    func getHomeList2() {
        print("==================home list=================")
        let urlString:String = "http://104.128.85.9:8001/api/gethomelist"
        let url:NSURL = NSURL(string: urlString)!
        
        //let request = NSURLRequest(URL: url)
        // 因为这个方法在ios9.0就会被废弃，所以用下面的方法代替
        //NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: getURLData)
        
        let urlSession:NSURLSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithURL(url, completionHandler: getURLData2)
        task?.resume()
    }
    func getNextList(timestamp:Int) {
        print("==================next list=================timestamp=\(timestamp)")
        let urlString:String = "http://104.128.85.9:8001/api/getnextlist?timestamp=" + String(timestamp)
        let url:NSURL = NSURL(string: urlString)!
        let urlSession:NSURLSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithURL(url, completionHandler: getURLData2)
        task?.resume()
    }
    func getStoryDetail(id:Int) {
        print("==================next list=================id=\(id)")
        let urlString:String = "http://104.128.85.9:8001/api/getstorydetail?id=" + String(id)
        let url:NSURL = NSURL(string: urlString)!
        let urlSession:NSURLSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithURL(url, completionHandler: getStoryData)
        task?.resume()
    }
    
    func getURLData(response:NSURLResponse?, data:NSData?, error:NSError?) -> Void {
        if error != nil {
            print("error")
            return
        }
        
        //let datastring = NSString(data: data!, encoding: NSUTF8StringEncoding)
        do {
            let json:AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            let number = json["number"] as! Int
            for i in 0..<number {
                let id = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("id") as! Int
                let title = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("title") as! String
                let strDate = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("display_date") as! String
                let img = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("images") as! String
                let timestamp = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("timestamp") as! Int
                
                print("id=\(id)")
                print("title=\(title), date=\(strDate), timestamp=\(timestamp)")
                print("img=\(img)")
                print("********************************")
            }
        } catch {
            print("exception.")
        }
    }
    
    func getURLData2(data:NSData?, response:NSURLResponse?, error:NSError?) -> Void {
        print("-------------url session---------")
        if error != nil {
            print("error")
            return
        }
        
        var json:AnyObject

        do {
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        } catch {
            print("exception.")
            return
        }
        let number = json["number"] as! Int
        for i in 0..<number {
            let id = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("id") as! Int
            let title = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("title") as! String
            let strDate = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("display_date") as! String
            let img = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("images") as! String
            let timestamp = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("timestamp") as! Int
            
            print("id=\(id)")
            print("title=\(title), date=\(strDate), timestamp=\(timestamp)")
            print("img=\(img)")
            print("********************************")
        }
        self.id = json.objectForKey("stories")?.objectAtIndex(number-1).objectForKey("timestamp") as! Int
        let today = json.objectForKey("stories")?.objectAtIndex(0).objectForKey("id") as! Int
        getStoryDetail(today)
    }
    
    func getStoryData(data:NSData?, response:NSURLResponse?, error:NSError?) -> Void {
        print("-------------url detail session---------")
        if error != nil {
            print("error")
            return
        }
        
        var json:AnyObject
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        } catch {
            print("story detail exception.")
            return
        }
        
        let quest_num:Int = json.objectForKey("question_num") as! Int
        for i in 0..<quest_num {
            let question_title:String = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("question_title") as! String
            print("question: \(question_title)")
            let answer_num:Int = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("answer_num") as! Int
            for j in 0..<answer_num {
                let author:String = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("answers")?.objectAtIndex(j).objectForKey("author") as! String
                let bio:String = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("answers")?.objectAtIndex(j).objectForKey("bio") as! String
                let answer:String = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("answers")?.objectAtIndex(j).objectForKey("answer") as! String
                print("author: \(author), \(bio)")
                print("answer: \(answer)")
                print("--------------------------")
            }
            let viewmore:String = json.objectForKey("stories")?.objectAtIndex(i).objectForKey("viewmore") as! String
            print("viewmore: \(viewmore)")
            print("************************************************************************")
        }
    }
}
