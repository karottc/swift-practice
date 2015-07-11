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
    
    var gmodel:GameModelMatrix!
    var score:ScoreView!
    var bestscore:ScoreView!
    
    // 保存界面上的数字label
    var tiles: Dictionary<NSIndexPath, TileView>!
    // 保存界面上的值label
    var tileVals: Dictionary<NSIndexPath, Int>!
    
    init() {
        super.init(nibName:nil, bundle:nil)
        self.backgrounds = Array<UIView>()
        
        self.tiles = Dictionary()
        self.tileVals = Dictionary()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 改成主视图背景：白色背景
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupGameMap()
        
        setupScoreLabels()
        
        self.gmodel = GameModelMatrix(dimension: self.dimension)
        
        for i in 0..<6 {
            genNumber()
        }
        //genNumber()
        //while genNumber() != 0 {
        //}
    }
    
    func setupGameMap() {
        var x:CGFloat = 50
        var y:CGFloat = 150
        
        for i in 0..<dimension {
            //print(i)
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
        score = ScoreView(stype: ScoreType.Common)
        score.frame.origin = CGPointMake(50, 80)
        score.changeScore(value: 0)
        self.view.addSubview(score)
        
        bestscore = ScoreView(stype: ScoreType.Best)
        bestscore.frame.origin.x = 170
        bestscore.frame.origin.y = 80
        bestscore.changeScore(value: 0)
        self.view.addSubview(bestscore)
    }
    
    func genNumber() -> Int {
        // 用于确定随机数的概率
        let randv = Int(arc4random_uniform(10))
        //print(randv)
        var seed:Int = 2
        // 因为有10%的机会，出现1，所以这里是10%的机会给4
        if 1 == randv {
            seed = 4
        }
        // 随机生成行号和列号
        let col = Int(arc4random_uniform(UInt32(dimension)))
        let row = Int(arc4random_uniform(UInt32(dimension)))
        
        if gmodel.isFull() {
            print("位置已经满了")
            gmodel.printTiles()
            return 0
        }
        if gmodel.setPosition(row, col: col, value: seed) == false {
            return genNumber()
        }
        print("插入位置：\(row),\(col)")
        // 执行后续操作
        insertTile((row, col), value:seed)
        return 2
    }
    
    func insertTile(pos: (Int, Int), value: Int) {
        let (row, col) = pos
        
        // 地图的起始位置是 50,150
        let x = 50 + CGFloat(col) * (width + padding)
        let y = 150 + CGFloat(row) * (width + padding)
        
        let tile = TileView(pos: CGPointMake(x, y), width:width, value:value)
        self.view.addSubview(tile)
        self.view.bringSubviewToFront(tile)
        var index = NSIndexPath(forRow: row, inSection: col)
        tiles[index] = tile
        tileVals[index] = value
        
        // 先将数字块的大小置为原始尺寸的1/10
        tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        // 设置动画效果，动画时间长度1秒
        UIView.animateWithDuration(1, delay: 0.01, options: UIViewAnimationOptions.TransitionNone, animations: {
            () -> Void in
            // 在动画中数字块有一个角度的旋转
            tile.layer.setAffineTransform(CGAffineTransformMakeRotation(90))
            },
            completion: {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(1, animations: {
                    () -> Void in
                    // 完成动画时，数字块复原
                    tile.layer.setAffineTransform(CGAffineTransformIdentity)
                })
            })
        
        //UIView.beginAnimations("animation", context: nil)
        //UIView.setAnimationDuration(2)
        //UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
        //UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromLeft, forView: self.view, cache: false)
        //UIView.setAnimationTransition(<#T##transition: UIViewAnimationTransition##UIViewAnimationTransition#>, forView: <#T##UIView#>, cache: <#T##Bool#>)
        //UIView.commitAnimations()
    }
    
    // 根据数据模型重新生成UI
    func initUI() {
        for i in 0..<self.dimension {
            for j in 0..<self.dimension {
                if self.gmodel.tiles[i, j] != 0 {
                    insertTile((i, j), value: self.gmodel.tiles[i, j])
                }
            }
        }
    }
    
    // 将所有数字从地图上移除
    func resetUI() {
        for (key, tile) in tiles {
            tile.removeFromSuperview()
        }
        tiles.removeAll(keepCapacity: true)
        tileVals.removeAll(keepCapacity: true)
    }
}