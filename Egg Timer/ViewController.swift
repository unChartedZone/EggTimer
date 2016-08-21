//
//  ViewController.swift
//  Navigation Bar
//
//  Created by Chris on 8/17/16.
//  Copyright © 2016 ChrisBV. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timeCounter = 1
    var timer: NSTimer?
    var countingStarted = false
    var pausedButtonPressed = false
    @IBOutlet var timerLabel: UILabel!

    func checkForMinute(currentValueOfCounter: Int) {
        let minuteChecker = String(currentValueOfCounter) //minuteChecker is string version of timeCounter
        var stringLength = minuteChecker.characters.count
        if stringLength >= 2 {
            //This is where we actually start checking for minute
            let subString = minuteChecker.substringWithRange(Range<String.Index>(minuteChecker.startIndex.advancedBy(stringLength - 2) ..< minuteChecker.endIndex))
            if subString == "60" {
                timeCounter += 40
            }
        }
    }

    //Needed for timer, recursive, and only from playButton
    func result()  {
        var temp = String(format: "%04d", timeCounter)
        temp.insert(":", atIndex: temp.startIndex.advancedBy(2))
        timerLabel.text = temp //Sets label to new time
        timeCounter += 1
        checkForMinute(timeCounter)
    }

    @IBAction func playButton(sender: AnyObject) {
        if countingStarted && !pausedButtonPressed {
            return
        }
        if !pausedButtonPressed {
            timeCounter = 0
        }
        countingStarted = true
        pausedButtonPressed = false
        timer = NSTimer()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseButton(sender: AnyObject) {
        if !countingStarted {
            return
        }
        timer!.invalidate()
        pausedButtonPressed = true
        print("Another")
    }

    @IBAction func stopButton(sender: AnyObject) {
        if !countingStarted {
            return
        }
        timer!.invalidate()
        timerLabel.text = "00:00"
        countingStarted = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

