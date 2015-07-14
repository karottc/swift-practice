//
//  SettingViewController.swift
//  game2048
//
//  Created by k on 15/7/6.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation
import UIKit

// 下面有一处需要传值，所以必须继承这个class：UITextFieldDelegate
class SettingViewController: UIViewController, UITextFieldDelegate {
    var txtNum:UITextField!
    var segDimension:UISegmentedControl!
    var mainview:MainViewController!
    
    required init?(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    convenience init(mainview:MainViewController) {
        self.init(nibName:nil, bundle:nil)
        self.mainview = mainview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupControls()
    }
    
    func setupControls() {
        //var txtNum = ViewFactory.createTextField("", action:"numChanged", sender: self)
        txtNum = ViewFactory.createTextField("", action:Selector("numChanged"), sender:self)
        txtNum.frame = CGRect(x: 80, y: 100, width: 200, height: 30)
        txtNum.returnKeyType = UIReturnKeyType.Done
        
        self.view.addSubview(txtNum)
        
        let labelNum = ViewFactory.createLabel("阈值")
        labelNum.frame = CGRect(x: 20, y: 100, width: 60, height: 30)
        self.view.addSubview(labelNum)
        
        //创建分段单选控件
        segDimension = ViewFactory.createSegment(["3x3", "4x4", "5x5"], action:"dimensionChanged:", sender:self)
        
        segDimension.frame = CGRect(x: 80, y: 200, width: 200, height: 30)
        
        self.view.addSubview(segDimension)
        
        segDimension.selectedSegmentIndex = 1
        
        let labelDm = ViewFactory.createLabel("维度：")
        labelDm.frame = CGRect(x: 20, y: 200, width: 60, height: 30)
        self.view.addSubview(labelDm)
    }
    
    func dimensionChanged(sender: SettingViewController) {
        var setVals = [3, 4, 5]
        mainview.dimension = setVals[segDimension.selectedSegmentIndex]
        if 5 == mainview.dimension {
            mainview.width = 100
        } else {
            mainview.width = 150
        }
        mainview.resetTapped()
        // 保存维度数据到本地SQLite数据库
        // TODO: 现在写入sqlite库还有问题
        let usermodel = UserModel(dimension: mainview.dimension, maxnum: 2048, backgroundColor: UIColor.blueColor())
        usermodel.save_dimension(mainview.dimension)
        var dict = usermodel.get_userdata()
        print(dict)
    }
}