//
//  ViewController.swift
//  testUIkit
//
//  Created by k on 15/7/3.
//  Copyright (c) 2015年 com.karottc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView = UIImageView(image:UIImage(named:"icon"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let label = UILabel(frame:CGRectMake(10, 20, 300, 100))
        label.text = "《Swift语言实战入门》这是一本我去我也不知道为什么这么多页的书"
        
        self.view.addSubview(label)
        
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.blackColor()
        
        label.textAlignment = NSTextAlignment.Right
        
        label.shadowColor = UIColor.grayColor()
        label.shadowOffset = CGSizeMake(-5, 5)
        
        label.font = UIFont(name: "Zapfino", size:20)
        
        label.lineBreakMode = NSLineBreakMode.ByTruncatingMiddle
        
        label.adjustsFontSizeToFitWidth = true   // 这句文字不会被隐藏
        
        label.numberOfLines = 2
        
        // button
        //let button:UIButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        let button:UIButton = UIButton(type: UIButtonType.ContactAdd)
        button.frame = CGRectMake(10, 150, 100, 30)
        button.setTitle(" 加号按钮", forState: UIControlState.Normal)
        button.setTitleShadowColor(UIColor.greenColor(), forState: .Normal)
        button.setTitleShadowColor(UIColor.yellowColor(), forState: .Highlighted)
        self.view.addSubview(button)
        //button.backgroundColor = UIColor.blackColor()
        button.setImage(UIImage(named:"icon"), forState: .Normal)
        button.adjustsImageWhenDisabled = false
        button.addTarget(self, action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let button2:UIButton = UIButton(type: UIButtonType.DetailDisclosure)
        button2.frame = CGRectMake(10, 200, 200, 30)
        button2.setTitle(" 感叹号按钮", forState: UIControlState.Normal)
        self.view.addSubview(button2)
        // tapped加上：符号是为了获得按钮对象
        button2.addTarget(self, action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let button3:UIButton = UIButton(type: UIButtonType.System)
        button3.frame = CGRectMake(10, 250, 200, 30)
        button3.setTitle(" 系统默认按钮", forState: UIControlState.Normal)
        self.view.addSubview(button3)
        button3.addTarget(self, action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let button4:UIButton = UIButton(type: UIButtonType.Custom)
        button4.frame = CGRectMake(10, 300, 200, 30)
        button4.setTitle(" 啥都没有按钮", forState: UIControlState.Normal)
        button4.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.view.addSubview(button4)
        button4.addTarget(self, action: Selector("tapped:"), forControlEvents: UIControlEvents.TouchUpInside)
        
        // 创建文本框
        let textField = UITextField(frame: CGRectMake(10, 350, 200, 30))
        // 设置边框样式为圆角矩形
        textField.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(textField)
        textField.placeholder = "请输入用户名"
        //textField.text = "请输入名字"   // 设置默认值
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 14
        textField.becomeFirstResponder()
        textField.returnKeyType = UIReturnKeyType.Done
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        
        // 选择控件
        var items = ["选项一", "选项二", "选项三"]
        var segmented = UISegmentedControl(items: items)
        segmented.center = self.view.center
        segmented.selectedSegmentIndex = 1
        self.view.addSubview(segmented)
        segmented.addTarget(self, action: "segmentDidchange:", forControlEvents: UIControlEvents.ValueChanged)
        
        // 图像控件
        //var imageView = UIImageView(image:UIImage(named:"icon"))
        //var imageView = UIImageView(image:UIImage(named:"icon"))
        imageView.frame = CGRectMake(10, 400, 200, 200)
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped(button:UIButton) {
        //print("tapped")
        print(button.titleForState(.Normal))
    }
    
    func segmentDidchange(segmented:UISegmentedControl) {
        var index:Int = segmented.selectedSegmentIndex
        print(index)
        // 获取文字
        print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
        // 图像控件
        switch index {
        case 0:
            imageView.image = UIImage(named: "icon")
        case 1:
            imageView.image = UIImage(named: "icon2")
        case 2:
            imageView.image = UIImage(named: "icon3")
        default:
            print("error select")
        }
    }
}

