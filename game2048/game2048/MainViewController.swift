//
//  MainViewController.swift
//  game2048
//
//  Created by k on 15/7/6.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    // 游戏方格纬度
    var dimension:Int = 4
    // 游戏过关数值
    var maxnumber:Int = 2048
    
    // 数字格子的宽度
    var width:CGFloat = 150
    // 格子之间的距离
    var padding:CGFloat = 12
    
    // 保存背景图数据
    var backgrounds:Array<UIView>!
    
    init() {
        super.init(nibName:nil, bundle:nil)
        self.backgrounds = Array<UIView>()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 改成主视图背景：白色背景
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupGameMap()
        
        setupScoreLabels()
    }
    
    func setupGameMap() {
        var x:CGFloat = 50
        var y:CGFloat = 150
        
        for i in 0..<dimension {
            print(i)
            y = 150
            for j in 0..<dimension {
                // 初始化视图
                var background = UIView(frame:CGRectMake(x, y, width, width))
                background.backgroundColor = UIColor.darkGrayColor()
                
                self.view.addSubview(background)
                
                // 将视图保存起来备用
                backgrounds.append(background)
                y += padding + width
            }
            x += padding + width
        }
    }
    
    func setupScoreLabels() {
        var score = ScoreView(stype: ScoreType.Common)
        score.frame.origin = CGPointMake(50, 80)
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        var bestscore = ScoreView(stype: ScoreType.Best)
        bestscore.frame.origin.x = 170
        bestscore.frame.origin.y = 80
        bestscore.changeScore(value: 0)
        self.view.addSubview(bestscore)
    }
}