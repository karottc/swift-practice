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
    }
    
}