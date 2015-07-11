//
//  MainTabViewController.swift
//  game2048
//
//  Created by k on 15/7/6.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation
import UIKit

class MainTabViewController:UITabBarController {
    // 一共包含两个视图
    var viewMain:MainViewController!
    var viewSetting:SettingViewController!
    
    var main:UINavigationController!
    var setting:UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewMain = MainViewController()
        viewMain.title = "2048"
        
        viewSetting = SettingViewController()
        viewSetting.title = "设置"
        
        // 分别声明两个视图控制器
        main = UINavigationController(rootViewController: viewMain)
        setting = UINavigationController(rootViewController: viewSetting)
        self.viewControllers = [main, setting]
        
        // 默认选中的是游戏主界面视图
        self.selectedIndex = 0
        
        setupSwipeGuestures()
    }
    
    func setupSwipeGuestures() {
        // 监控向上的方向，相应的处理方法swipeup
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeUp"))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(upSwipe)
        // 监控向下的方向
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeDown"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeLeft"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeRight"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    func _showTip(direction:String) {
        let alertcontroller = UIAlertController(title: "提示", message: "你刚刚向\(direction)滑动了！", preferredStyle: UIAlertControllerStyle.Alert)
        alertcontroller.addAction(UIAlertAction(title: "确定", style:UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alertcontroller, animated: true, completion: nil)
    }
    
    func swipeUp() {
        print("swipeUp")
        //_showTip("上")
        self.viewMain.gmodel.reflowUp()
        self.viewMain.gmodel.mergeUp()
        reGenUI()
    }
    func swipeDown() {
        print("swipeDown")
        //_showTip("下")
        self.viewMain.gmodel.reflowDown()
        self.viewMain.gmodel.mergeDown()
        reGenUI()
    }
    func swipeLeft() {
        print("swipeLeft")
        //_showTip("左")
        self.viewMain.gmodel.reflowLeft()
        self.viewMain.gmodel.mergeLeft()
        reGenUI()
    }
    func swipeRight() {
        print("swipeRight")
        //_showTip("右")
        self.viewMain.gmodel.reflowRight()
        self.viewMain.gmodel.mergeRight()
        reGenUI()
    }
    
    func reGenUI() {
        //self.viewMain.resetUI()
        
        self.viewMain.initUI()
        for i in 0..<2 {
            if 0 == self.viewMain.genNumber() {
                break
            }
        }
    }
}