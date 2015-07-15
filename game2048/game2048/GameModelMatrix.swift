//
//  GameModelMatrix.swift
//  game2048
//
//  Created by k on 15/7/8.
//  Copyright © 2015年 com.karottc. All rights reserved.
//

import Foundation

struct Matrix {
    let rows:Int, columns:Int
    var grid: [Int]
    init(rows:Int, columns:Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0)
    }
    
    func indexIsValidForRow(row:Int, column:Int) -> Bool {
        return 0 <= row && row < rows && 0 <= column && column < columns
    }
    
    subscript(row:Int, column:Int) -> Int {
        get {
            assert(indexIsValidForRow(row, column: column), "超出范围")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "超出范围")
            return grid[(row * columns) + column] = newValue
        }
    }
}

class GameModelMatrix {
    var dimension:Int = 0
    var tiles:Matrix
    var mtiles:Matrix  // 移动时的辅助副本
    
    var scoredelegate:ScoreViewProtocol!
    var bestscoredelegate:ScoreViewProtocol!
    
    var score:Int = 0
    var bestscore:Int = 0
    
    // 由外部传入维度
    init(dimension:Int, bestscores:Int, score: ScoreViewProtocol, bestscore:ScoreViewProtocol) {
        self.dimension = dimension
        
        self.scoredelegate = score
        self.bestscoredelegate = bestscore
        
        self.tiles = Matrix(rows: self.dimension, columns: self.dimension)
        self.mtiles = Matrix(rows: self.dimension, columns: self.dimension)
        
        self.bestscore = bestscores
    }
    
    func initTiles() {
        self.tiles = Matrix(rows: self.dimension, columns: self.dimension)
        self.mtiles = Matrix(rows: self.dimension, columns: self.dimension)
    }
    
    // 找出空位
    func emptyPositions() -> [Int] {
        var emptytiles = Array<Int>()
        // var index:Int
        for row in 0..<self.dimension {
            for col in 0..<self.dimension {
                var val = tiles[row, col]
                if (val == 0) {
                    emptytiles.append(tiles[row, col])
                }
            }
        }
        return emptytiles
    }
    
    // 位置是否已满
    func isFull() -> Bool {
        if 0 == emptyPositions().count {
            return true
        }
        return false
    }
    // 输出当前数据模型
    func printTiles() {
        print(tiles)
        print("输出数据模型数据")
        for row in 0..<self.dimension {
            for col in 0..<self.dimension {
                print("\(tiles[row, col])\t", appendNewline: false)
            }
            print("")
        }
        print("")
    }
    
    func setPosition(row:Int, col:Int, value:Int) -> Bool {
        assert(row >= 0 && row < dimension)
        assert(0 <= col && col < dimension)
        // 3行4列： row=2, col=3 , index=2*4 + 3 = 11
        //var index = self.dimension * row + col
        var val = tiles[row, col]
        if val > 0 {
            print("该位置(\(row), \(col))已经有值了 : \(val)")
            //printTiles()
            return false
        }
        tiles[row, col] = value
        return true
    }
    
    func reflowUp() {
        //printTiles()
        copyToMtiles()
        
        // 从最后一行开始往上找
        // 向上滑，第一行不用动
        for var i = dimension-1; i>0; i-- {
            for j in 0..<dimension {
                // 如果当前位置上有值，上一行没有值
                if 0 == mtiles[i - 1, j] && mtiles[i, j] > 0 {
                    // 把下一行的值复制到上一行
                    mtiles[i - 1, j] = mtiles[i, j]
                    mtiles[i, j] = 0
                    
                    // 移动这一行，后面的行如果有值，也应该跟上
                    var k = i
                    while ++k < dimension {
                        if mtiles[k, j] > 0 {
                            mtiles[k - 1, j] = mtiles[k, j]
                            mtiles[k, j] = 0
                        }
                    }
                }
            }
        }
        copyFromMtiles()
        printTiles()
    }
    // 合并
    func mergeUp() {
        copyToMtiles()
        for i in 0..<self.dimension-1 {
            for j in 0..<self.dimension {
                if mtiles[i, j] > 0 && mtiles[i, j] == mtiles[i+1, j] {
                    mtiles[i, j] = mtiles[i, j] * 2
                    mtiles[i+1, j] = 0
                    
                    changeScore(mtiles[i, j])
                    
                    // 后面补起
                    var k = i + 1
                    while ++k < dimension {
                        if mtiles[k, j] > 0 {
                            mtiles[k-1, j] = mtiles[k, j]
                            mtiles[k, j] = 0
                        }
                    }
                }
            }
        }
        copyFromMtiles()
        printTiles()
    }
    func reflowDown() {
        //printTiles()
        copyToMtiles()
        
        // 从第一行开始往下
        for i in 0..<self.dimension-1 {
            for j in 0..<dimension {
                // 如果当前位置上有值，下一行没有值
                if 0 == mtiles[i + 1, j] && mtiles[i, j] > 0 {
                    // 把下一行的值复制到上一行
                    mtiles[i + 1, j] = mtiles[i, j]
                    mtiles[i, j] = 0
                    
                    // 移动这一行，上面的行如果有值，也应该跟上
                    var k = i
                    while --k >= 0 {
                        if mtiles[k, j] > 0 {
                            mtiles[k + 1, j] = mtiles[k, j]
                            mtiles[k, j] = 0
                        }
                    }
                }
            }
        }
        copyFromMtiles()
        printTiles()
    }
    func mergeDown() {
        copyToMtiles()
        for var i = self.dimension-1; i > 0; --i {
            for j in 0..<self.dimension {
                if mtiles[i, j] > 0 && mtiles[i, j] == mtiles[i-1,j] {
                    mtiles[i,j] *= 2
                    mtiles[i-1, j] = 0
                    
                    changeScore(mtiles[i, j])
                    
                    var k = i - 1
                    while --k >= 0 {
                        if mtiles[k, j] > 0 {
                            mtiles[k+1, j] = mtiles[k, j]
                            mtiles[k, j] = 0
                        }
                    }
                }
            }
        }
        copyFromMtiles()
        printTiles()
    }
    func reflowLeft() {
        //printTiles()
        copyToMtiles()
        
        // 从最右列开始移动
        // 此处，i 表示列，j 表示行
        for var i = dimension-1; i>0; i-- {
            for j in 0..<dimension {
                if 0 == mtiles[j, i - 1] && mtiles[j, i] > 0 {
                    mtiles[j, i - 1] = mtiles[j, i]
                    mtiles[j, i] = 0
                    
                    var k = i
                    while ++k < dimension {
                        if mtiles[j, k] > 0 {
                            mtiles[j, k - 1] = mtiles[j, k]
                            mtiles[j, k] = 0
                        }
                    }
                }
            }
        }
        copyFromMtiles()
        printTiles()
    }
    func mergeLeft() {
        copyToMtiles()
        // 从最左列开始移动
        for i in 0..<self.dimension-1 {
            for j in 0..<self.dimension {
                if mtiles[j, i] > 0 && mtiles[j, i] == mtiles[j, i+1] {
                    mtiles[j, i] *= 2
                    mtiles[j, i+1] = 0
                    
                    changeScore(mtiles[j, i])
                    
                    var k = i + 1
                    while ++k < self.dimension {
                        if mtiles[j, k] > 0{
                            mtiles[j, k-1] = mtiles[j, k]
                            mtiles[j, k] = 0
                        }
                    }
                }
            }
        }
        copyFromMtiles()
        printTiles()
    }
    func reflowRight() {
        //printTiles()
        copyToMtiles()
        
        // 从最左列开始移动
        // 此处，i 表示列，j 表示行
        for i in 0..<self.dimension-1 {
            for j in 0..<dimension {
                if 0 == mtiles[j, i + 1] && mtiles[j, i] > 0 {
                    mtiles[j, i + 1] = mtiles[j, i]
                    mtiles[j, i] = 0
                    
                    var k = i
                    while --k >= 0 {
                        if mtiles[j, k] > 0 {
                            mtiles[j, k + 1] = mtiles[j, k]
                            mtiles[j, k] = 0
                        }
                    }
                }
            }
        }
        copyFromMtiles()
        printTiles()
    }
    func mergeRight() {
        copyToMtiles()
        // 从最右列开始合并
        for var i = self.dimension-1; i > 0; --i {
            for j in 0..<self.dimension {
                if mtiles[j, i] > 0 && mtiles[j, i] == mtiles[j, i-1] {
                    mtiles[j, i] *= 2
                    mtiles[j, i-1] = 0
                    changeScore(mtiles[j, i])
                    
                    var k = i - 1
                    while --k >= 0 {
                        if mtiles[j, k] > 0 {
                            mtiles[j, k+1] = mtiles[j, k]
                            mtiles[j, k] = 0
                        }
                    }
                }
            }
        }
        copyFromMtiles()
        printTiles()
    }
    
    func copyToMtiles() {
        for i in 0..<self.dimension {
            for j in 0..<self.dimension {
                mtiles[i, j] = tiles[i, j]
            }
        }
    }
    func copyFromMtiles() {
        for i in 0..<self.dimension {
            for j in 0..<self.dimension {
                tiles[i, j] = mtiles[i, j]
            }
        }
    }
    
    func changeScore(s:Int) {
        score += s
        if score >= bestscore {
            bestscore = score
            bestscoredelegate.changeScore(value: bestscore)
            let usermodel = UserModel()
            usermodel.save_bestscores(bestscore)
        }
        scoredelegate.changeScore(value: score)
    }
    
    deinit {
        let usermodel = UserModel()
        usermodel.save_bestscores(bestscore)
    }
    
}