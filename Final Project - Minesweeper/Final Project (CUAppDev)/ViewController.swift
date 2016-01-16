//
//  ViewController.swift
//  Final Project (CUAppDev)
//
//  Created by Annie Cheng on 1/20/15.
//  Copyright (c) 2015 Annie Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var faceView: UIImageView!
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var levelController: UISegmentedControl!
    
    // Variable declarations
    var boardSize = 16
    var board: Board
    var gridButtons:[GridButton] = []
    var youWon = false
    var timer: NSTimer?
    var highScore = 0
    var score: Int = 0 {
        didSet {
            self.scoreLabel.text = "Score: \(score)"
            self.scoreLabel.sizeToFit()
        }
    }
    var time: Int = 0 {
        didSet {
            self.timeLabel.text = "Time: \(time)"
            self.timeLabel.sizeToFit()
        }
    }
    
    //Initialization
    required init?(coder aDecoder: NSCoder)
    {
        self.board = Board(size: boardSize)
        board.size = 8
        super.init(coder: aDecoder)
    }
    
    // When view loads for the first time
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeBoard()
        self.resetGame()
    }
    
    // Initialize board when app first launches
    func initializeBoard() {
        
        // Clear previous board
        gridButtons.removeAll(keepCapacity: false)
        for view in self.boardView.subviews {
            view.removeFromSuperview()
        }
        
        // Set grid size
        let gridSize:CGFloat = self.boardView.frame.width / CGFloat(board.size)
        
        // Make all grids on board
        for r in 0 ..< board.size {
            for c in 0 ..< board.size {
                let gridButton = GridButton(grid: board.grids[r][c], gridSize: gridSize)
                gridButton.setImage(UIImage(named: "grid"), forState: .Normal)
                gridButton.addTarget(self, action: "gridButtonPressed:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(gridButton)
                self.gridButtons.append(gridButton)
            }
        }
    }
    
    // When user presses a grid
    func gridButtonPressed(sender: GridButton) {
        
        checkForWin() // Check for win
        
        // Grid has not been pressed before
        if !sender.grid.known {
            sender.grid.known = true
            sender.enabled = false
        }
        
        // Reveal grid label
        if checkForWin() {
            sender.setImage(nil, forState: .Normal)
            self.score++
            revealCongratulatoryMessage()
        } else {
            // Grid has mine
            if sender.grid.hasMine {
                sender.setImage(UIImage(named: "mine"), forState: .Normal)
                self.minePressed()
                for button in gridButtons {
                    button.enabled = false
                    if button.grid.hasMine {
                        button.setImage(UIImage(named: "mine"), forState: .Normal)
                    }
                }
            } else {
                getGridLabel(sender)
                self.score++
            }
        }
    }
    
    // Check for victory
    func checkForWin() -> Bool {
        for button in gridButtons {
            if !button.grid.hasMine && !button.grid.known {
                return false
            }
        }
        return true
    }
    
    // Show number of neighboring mines when grid with no mine is tapped
    func getGridLabel(sender: GridButton) {
        sender.setImage(nil, forState: .Normal)
        if sender.grid.adjacentMines == 0 {
            sender.setTitle("", forState: .Normal)
        } else {
            sender.setTitle("\(sender.grid.adjacentMines)", forState: .Normal)
        }
        sender.setTitleColor(getColor(sender.grid.adjacentMines) as UIColor, forState: .Normal)
    }
    
    // Get color of number
    func getColor(number: Int) -> UIColor! {
        var color: UIColor!
        if number == 1 {
            color = UIColor.blueColor()
        } else if number == 2 {
            color = UIColor.greenColor()
        } else if number == 3 {
            color = UIColor.redColor()
        } else if number == 4 {
            color = UIColor.purpleColor()
        } else if number == 5 {
            color = UIColor.magentaColor()
        } else if number == 6 {
            color = UIColor.cyanColor()
        } else if number == 7 {
            color = UIColor.blackColor()
        } else {
            color = UIColor.grayColor()
        }
        return color
    }
    
    // Reset the game
    func resetGame() {
        self.board.newBoard()
        self.time = 0
        self.score = 0
        scoreLabel.text = "Score: \(score)"
        timeLabel.text = "Time: \(time)"
        faceView.image = UIImage(named: "smiley.png")
        for gridButton in self.gridButtons {
            gridButton.enabled = true
            gridButton.setImage(UIImage(named: "grid"), forState: .Normal)
        }
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("countTime"), userInfo: nil, repeats: true)
    }
    
    // Button
    @IBAction func newGamePressed() {
        self.endGame()
        self.resetGame()
    }
    
    // Change difficulty level
    @IBAction func changeLevel(sender: UISegmentedControl) {
        if levelController.selectedSegmentIndex == 0 {
            board.size = 8
        } else if levelController.selectedSegmentIndex == 1 {
            board.size = 10
        } else if levelController.selectedSegmentIndex == 2 {
            board.size = 12
        } else if levelController.selectedSegmentIndex == 3 {
            board.size = 14
        } else {
            board.size = 16
        }
        initializeBoard()
        self.endGame()
        self.resetGame()
    }
    
    // Notify player of loss
    func minePressed() {
        self.endGame()
        faceView.image = UIImage(named: "frowny.png")
    }
    
    // Update time
    func countTime() {
        self.time++
        timeLabel.text = "Time: \(time)"
    }
    
    // Notify player of victory
    func revealCongratulatoryMessage() {
        self.endGame()
        let alertView = UIAlertView()
        alertView.addButtonWithTitle("New Game")
        alertView.title = "CONGRATS!"
        if self.score > highScore {
            highScore = self.score
        }
        alertView.message = "You won! :D \n High Score: \(highScore)"
        alertView.show()
        alertView.delegate = self
    }
    
    // Restart game when alert is dismissed
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        self.resetGame()
    }
    
    // Stops current game
    func endGame() {
        self.timer!.invalidate()
    }
}


