//
//  ViewController.swift
//  Calculator4FollowingLecture
//
//  Created by justin on 10/07/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import UIKit


//TODO: UI testing (automatic testing) 
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
    
    @IBAction private func pressedDigit(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            //TODO: is it really save? to unwrap "displayLabel.text!" and "sender.currentTitle!"
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

