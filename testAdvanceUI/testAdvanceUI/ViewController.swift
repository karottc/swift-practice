//
//  ViewController.swift
//  testAdvanceUI
//
//  Created by k on 15/7/5.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var dpicker:UIDatePicker?
    @IBOutlet var btnshow:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(dpicker!.locale!.localeIdentifier)
        print(dpicker!.calendar.calendarIdentifier)
        var date = dpicker!.date
        print(date.descriptionWithLocale(dpicker!.locale))
    }
    
    @IBAction func showClicked(sender:UIButton) {
        var date = dpicker!.date
        
        // 创建一个日期格式器
        var dformatter = NSDateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        var datestr = dformatter.stringFromDate(date)
        
        var message = "选择的日期和时间是 \(datestr)"
        
        // 用UIAlterView对象弹框显示
        //let alertView = UIAlertView()
        let alertView = UIAlertController(title:"", message:"",preferredStyle:UIAlertControllerStyle.Alert)
        //alertView.preferredStyle:UIAlertControllerStyle.Alert
        alertView.title = "当前日期和时间"
        alertView.message = message
        //alertView.addButtonWithTitle("确定")
        //alertView.show()
        let cancelAction = UIAlertAction(title: "点我", style: .Default, handler: {(action:UIAlertAction) in
            })
        
        alertView.addAction(cancelAction)
        self.presentViewController(alertView, animated:true) {
        }
        print(message)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

