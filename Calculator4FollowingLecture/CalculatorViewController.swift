//
//  ViewController.swift
//  Calculator4FollowingLecture
//
//  Created by justin on 10/07/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import UIKit


//TODO: UI testing (automatic testing) 
// 1) press "." and then a number, ".5" will cause crash? Expected behavior is after pressing "5", should display 0.5
// 2) press "." only, should change display to "0.", but if press "=" next, should display "0"
// 3) press a number, then press ".", e.g. 5. then press "=", should display "5"
// 4) what if pressed "5.4" and "+", and then pressed ".", should display "0."
// 5) press "5" and "+" and then press "-" and "2", result should be "3" not "5" 
// 6) press "7" and "+" and "=" should results in "14" 

//TODO: Version control using git and github

class CalculatorViewController: UIViewController {
    
    private var userIsInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()
    
    
    private var displayedNumericalValue: Double {
        get {
            //displayLabel.text should never be nil and should never be a non number string. if it is, that means there is a bug, explicitly unwrapping it will cause the program to crash, which is what I want
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    
    @IBOutlet private weak var displayLabel: UILabel!
    @IBOutlet weak var calculationStepsLabel: UILabel!
    
    //TODO: implement check for "." in one or two lines of code 
    @IBAction func pressedDot(sender: UIButton) {
        //TODO: where should be test for whether "." already exist be placed, in a separate function or inside "func pressedDigit(sender: UIButton){}", in other words, should "." button be treated as the same as number buttons or it should be treated as a different category of button
        
        //TODO: what if "." is pressed before a number, like "." and "5", which results in ".5"
        //TODO: what if only "." is pressed
        //TODO: press a number, then press ".", e.g. "5." then press "=", should display "5"
        //TODO: what if pressed "5.4" and "+", and then pressed ".", should display "0."
        
        if userIsInTheMiddleOfTyping {
            
            //"displayLabel.text" should never equal to nil or non number strings, should I use "if let" to safety unwrap "displayLabel.text" or should I not use "if let" and let unwrapping "displayLabel.text" crash if it contain nil
            if let displayLabelText = displayLabel.text where displayLabelText.rangeOfString(".") == nil{
                displayLabel.text! += sender.currentTitle!
                userIsInTheMiddleOfTyping = true
            }
        } else {
            //"displayLabel.text = "0."" take into accord two cases
            //1st case is when the calculator app just started and the first thing user pressed is "."
            //2nd case is when user uses the calculator, pressed a operation button, which reset "userIsInTheMiddleOfTyping" to false, and then pressed ".",
            displayLabel.text = "0."
            userIsInTheMiddleOfTyping = true 
        }
    }
    
    @IBAction private func pressedDigit(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            
            //TODO: is it really safe? to unwrap "displayLabel.text!" and "sender.currentTitle!"
            displayLabel.text! += sender.currentTitle!
            
        } else {
            displayLabel.text = sender.currentTitle!
            userIsInTheMiddleOfTyping = true
        }
        
    }
    
    //TODO: what if I treat constants as numbers instead of operation?
    @IBAction private func pressedOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            userIsInTheMiddleOfTyping = false
            brain.setOperand(displayedNumericalValue)
        }
        if let operation = sender.currentTitle {
            brain.performOperation(operation)
            //TODO: reasons on where to place "displayedNumericalValue = brain.result", inside or outside of "if let operation = sender.currentTitle {}"
            displayedNumericalValue = brain.result
        }
    }
    
    
}

