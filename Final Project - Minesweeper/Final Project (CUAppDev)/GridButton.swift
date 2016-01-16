//
//  GridButton.swift
//  Final Project (CUAppDev)
//
//  Created by Annie Cheng on 1/20/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class GridButton : UIButton {
    
    // Constant declarations
    var gridSize: CGFloat
    
    // Variable declarations
    var grid: Grid
    
    // Custom initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Constructor: initialize button for grid
    init(grid:Grid, gridSize:CGFloat) {
        self.grid = grid
        self.gridSize = gridSize
        let gridFrame = CGRectMake(CGFloat(self.grid.col)*gridSize,
            CGFloat(self.grid.row)*gridSize, gridSize, gridSize)
        super.init(frame: gridFrame)
    }
    
}
