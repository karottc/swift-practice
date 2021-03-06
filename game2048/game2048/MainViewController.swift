//
//  MainViewController.swift
//  game2048
//
//  Created by k on 15/7/6.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation
import UIKit

enum Animation2048Type {
    case None   //无动画
    case New    // 新出现动画
    case Merge  // 合并动画
}


class MainViewController : UIViewController {
    // 游戏方格纬度
    var dimension:Int = 4
    // 游戏过关数值
    var maxnumber:Int = 2048
    // 是否过关
    var isSuccess:Bool = false
    
    // 数字格子的宽度
    var width:CGFloat = 150
    // 格子之间的距离
    var padding:CGFloat = 12
    
    // 保存背景图数据
    var backgrounds:Array<UIView>!
    
    var gmodel:GameModelMatrix!
    var score:ScoreView!
    var bestscore:ScoreView!
    
    // 最高分
    var bestscores:Int = 0
    
    // 保存界面上的数字label
    var tiles: Dictionary<NSIndexPath, TileView>!
    // 保存界面上的值label
    var tileVals: Dictionary<NSIndexPath, Int>!
    
    init() {
        super.init(nibName:nil, bundle:nil)
        self.backgrounds = Array<UIView>()
        
        self.tiles = Dictionary()
        self.tileVals = Dictionary()
        
        let usermodel = UserModel()
        let dict = usermodel.get_userdata()
        if 0 != dict.count {
            self.maxnumber = Int(dict["maxnum"]!)!
            self.dimension = Int(dict["dimension"]!)!
            self.bestscores = Int(dict["bestscores"]!)!
            
            if 5 == self.dimension {
                self.width = 100
            }
        }
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
        
        self.gmodel = GameModelMatrix(dimension: self.dimension, bestscores:self.bestscores, score:score, bestscore:bestscore)
        
        for i in 0..<2 {
            genNumber()
        }
        //genNumber()
        //while genNumber() != 0 {
        //}
        
        setupSwipeGuestures()
    }
    
    func resetTapped() {
        print("reset")
        resetUI()
        gmodel.dimension = self.dimension

        gmodel.initTiles()
        for i in 0..<2 {
            self.genNumber()
        }
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
        bestscore.frame.origin.x = 300
        bestscore.frame.origin.y = 80
        bestscore.changeScore(value: self.bestscores)
        self.view.addSubview(bestscore)
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
        self.gmodel.reflowUp()
        self.gmodel.mergeUp()
        reGenUI()
    }
    func swipeDown() {
        print("swipeDown")
        //_showTip("下")
        self.gmodel.reflowDown()
        self.gmodel.mergeDown()
        reGenUI()
    }
    func swipeLeft() {
        print("swipeLeft")
        //_showTip("左")
        self.gmodel.reflowLeft()
        self.gmodel.mergeLeft()
        reGenUI()
    }
    func swipeRight() {
        print("swipeRight")
        //_showTip("右")
        self.gmodel.reflowRight()
        self.gmodel.mergeRight()
        reGenUI()
    }
    
    func reGenUI() {
        self.initUI()
        
        if isSuccess == false && self.maxnumber == self.gmodel.getMaxNum() {
            isSuccess = true
            // 弹框提示已经成功
            let message = "恭喜过关！！ 可以点击下面按钮继续冲击更高的分数！"
            let alertController = UIAlertController(title: "成功！", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Go on !", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated:true, completion: nil)
        } else {
            genNumber()
        }
        
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
        insertTile((row, col), value:seed, atype: Animation2048Type.New)
        return 2
    }
    
    func insertTile(pos: (Int, Int), value: Int, atype: Animation2048Type) {
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
        
        // 设置动画初始状态
        if atype == Animation2048Type.None {
            return
        } else if atype == Animation2048Type.New {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.1, 0.1))
        } else if atype == Animation2048Type.Merge {
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(0.8, 0.8))
        }
        
        // 设置动画效果，动画时间长度1秒
        UIView.animateWithDuration(0.3, delay: 0.01, options: UIViewAnimationOptions.TransitionNone, animations: {
            () -> Void in
            // 在动画中数字块有一个角度的旋转
            //tile.layer.setAffineTransform(CGAffineTransformMakeRotation(90))
            tile.layer.setAffineTransform(CGAffineTransformMakeScale(1, 1))
            },
            completion: {
                (finished:Bool) -> Void in
                UIView.animateWithDuration(0.08, animations: {
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
        var key:NSIndexPath
        var tile:TileView
        var tileVal:Int
        for i in 0..<self.dimension {
            for j in 0..<self.dimension {
                key = NSIndexPath(forRow: i, inSection: j)
                // 原来界面没有值，数据模型中有值
                if gmodel.tiles[i, j] > 0 && tileVals.indexForKey(key) == nil {
                    insertTile((i, j), value: gmodel.tiles[i, j], atype: Animation2048Type.Merge)
                }
                // 原来界面中有值，现在模型中没有值
                if gmodel.tiles[i, j] == 0 && tileVals.indexForKey(key) != nil {
                    tile = tiles[key]!
                    tile.removeFromSuperview()
                    
                    tiles.removeValueForKey(key)
                    tileVals.removeValueForKey(key)
                }
                // 原来有值，现在也有值
                if gmodel.tiles[i,j] > 0 && tileVals.indexForKey(key) != nil {
                    tileVal = tileVals[key]!
                    //如果不相等就替换
                    if tileVal != gmodel.tiles[i, j] {
                        tile = tiles[key]!
                        tile.value = gmodel.tiles[i, j]
                        tileVals[key] = gmodel.tiles[i, j]
                    }
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
        
        for background in backgrounds {
            background.removeFromSuperview()
        }
        
        setupGameMap()
        
        score.changeScore(value: 0)
        self.gmodel.score = 0
    }
}