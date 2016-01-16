//
//  Grid.swift
//  Final Project (CUAppDev)
//
//  Created by Annie Cheng on 1/20/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

class Grid {
    
    // Constant declarations
    let row:Int
    let col:Int
    
    // Constant declarations
    var adjacentMines = 0
    var known = false
    var hasMine = false
    
    // Constructor: initialize one grid on board
    init(row:Int, col:Int) {
        self.row = row
        self.col = col
    }
}