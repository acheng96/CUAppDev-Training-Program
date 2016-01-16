//
//  Board.swift
//  Final Project (CUAppDev)
//
//  Created by Annie Cheng on 1/20/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//
import Foundation

class Board {
    
    // Constant declarations
    var size: Int
    
    // Variable declarations
    var grids:[[Grid]] = [] // Empty 2D array
    
    // Constructor: initialize all grids on board
    init(size:Int) {
        self.size = size
        makeGrids() // Make 2D array of Grid objects
    }
    
    // Make grids for board
    func makeGrids() {
        grids.removeAll(keepCapacity: false)
        for r in 0 ..< size {
            var row:[Grid] = []
            for c in 0 ..< size {
                let grid = Grid(row: r, col: c)
                row.append(grid)
            }
            grids.append(row)
        }
    }
    
    // Reset mines and numbers
    func newBoard() {
        // Assign mines to grids
        for r in 0 ..< size {
            for c in 0 ..< size {
                grids[r][c].known = false
                grids[r][c].hasMine = (arc4random()%10 < 1)
            }
        }
        
        // Insert numbers
        for r in 0 ..< size {
            for c in 0 ..< size {
                self.numAdjacentMines(grids[r][c])
            }
        }
    }
    
    // Helper function: assign number of adjacent mines to grid
    func numAdjacentMines(grid: Grid) {
        
        var adjGrids:[Grid] = [] // Empty array
        var adjMines = 0
        
        // Adjacent positions
        let adjPos = [(-1,1),(0,1),(1,1),(-1,0),(1,0),(-1,-1),(0,-1),(1,-1)]
        
        // Make array of adjacent grids
        for (rowPos,colPos) in adjPos {
            let r = grid.row+rowPos
            let c = grid.col+colPos
            if r >= 0 && r < self.size && c >= 0 && c < self.size {
                adjGrids.append(grids[r][c])
            }
        }
        
        // Count number of adjacent mines
        for grid in adjGrids {
            if grid.hasMine {
                adjMines++
            }
        }
        
        // Set grid number to number of adjacent mines
        grid.adjacentMines = adjMines
    }

}