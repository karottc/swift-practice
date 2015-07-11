//
//  ScoreView.swift
//  game2048
//
//  Created by k on 15/7/6.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation
import UIKit

class ScoreView: UIView, ScoreViewProtocol {
    var label:UILabel!
    
    let defaultFrame = CGRectMake(0, 0, 100, 30)
    
    var stype:String!   // 显示最高分还是分数
    
    var score:Int = 0 {
        didSet {
            // 分数变化，标签内也要变化
            label.text = "\(stype): \(score)"
        }
    }
    
    // 传入分数面板的类型，用户控制标签的显示
    init(stype:ScoreType) {
        label = UILabel(frame: defaultFrame)
        label.textAlignment = NSTextAlignment.Center
        
        super.init(frame:defaultFrame)
        
        self.stype = (stype == ScoreType.Common ? "分数 " : "最高分 ")
        
        backgroundColor = UIColor.orangeColor()
        label.font = UIFont(name:"微软雅黑", size:16)
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    // 实现协议中的方法
    func changeScore(value s: Int) {
        score = s
    }
    
}