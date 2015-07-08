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
    
    // 由外部传入维度
    init(dimension:Int) {
        self.dimension = dimension
        
        self.tiles = Matrix(rows: self.dimension, columns: self.dimension)
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
}