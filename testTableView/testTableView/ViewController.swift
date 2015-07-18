//
//  ViewController.swift
//  testTableView
//
//  Created by k on 15/7/18.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ctrlnames:[String] = ["abc", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde5", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy30"]
    var tableView:UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 初始化数据，这一次数据，都放在属性列表文件里
        //self.ctrlnames = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("Controls", ofType: "plist")!) as! Array
        //self.ctrlnames = ["abc", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde5", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy", "cde", "exy30"]
        
        //print(self.ctrlnames)
        
        // 创建表视图
        //self.tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        //self.view.frame.offset(dx: 20, dy: 60)
        //self.tableView?.delegate = self
        //self.tableView!.dataSource = self
        // 创建一个重用单元格
        //self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        //self.view.addSubview(self.tableView!)
        
        /*
        // 创建表头标签
        let headerLabel = UILabel(frame: CGRectMake(20, 20, self.view.bounds.size.width, 30))
        headerLabel.backgroundColor = UIColor.blackColor()
        headerLabel.textColor = UIColor.whiteColor()
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        headerLabel.text = "常见 UIKit 控件"
        headerLabel.font = UIFont.italicSystemFontOfSize(20)
        self.tableView!.tableHeaderView = headerLabel
        */
        
    }
    
    // 本例中只有一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    // 返回表格的行数 (也就是返回控件数)
    func tableView(tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return self.ctrlnames.count
    }
    
    // 创建单元格显示的内容（indexPath指定单元格）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        // 同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        cell.textLabel!.text = self.ctrlnames[indexPath.row]

        return cell
    }
    
    // UITableViewDelegate方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        
        let itemString = self.ctrlnames[indexPath.row]
        
        let alertview = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alertview.title = "提示！"
        alertview.message = "你选中了【\(itemString)】"
        let action = UIAlertAction(title: "确定", style: .Default, handler: nil)
        alertview.addAction(action)
        self.presentViewController(alertview, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //override func loadView() {
    //    super.loadView()
    //}


}

