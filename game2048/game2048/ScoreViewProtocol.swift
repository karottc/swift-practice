//
//  ScoreViewProtocol.swift
//  game2048
//
//  Created by k on 15/7/6.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation

enum ScoreType {
    case Common   // 普通分数面板
    case Best     // 最高分面板
}

protocol ScoreViewProtocol {
    func changeScore(value s:Int)
}