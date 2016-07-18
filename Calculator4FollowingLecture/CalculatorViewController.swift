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
// 7)  after press "5" and "+", correctly display "5+..."
//     after press "5", "+", "6" and "+", correctly display "5+6..."
//     after press "5", "+", "6" and "=", correctly display "5+6="
// 8) press "π" and "calculationStepsLabel.text" display "π="
//    press "7, +, π" and "calculationStepsLabel.text" display "7+π..."
// 9) successfully displayed "8 +" after pressing "8" and "+"
//    successfully displayed "8 + 9 + " after pressing "8", "+", "9" and "+"
// 10) divide any number by 0, "displayLabel.text" should display not a number (this is yet to be implemented)
//11) user pressed "5" and pressed "D", instead of displaying nothing at "displayLabel.text", should display "0"
//12) user pressed "5, ., 6" and pressed "D", should display "5." at "displayLabel.text"
//13) user pressed "5, ., 6" and pressed "D", should display "5." at "displayLabel.text", and pressed "+", should work at normal
//14) when user press "8" and "D", "displayLabel.text" should not be blank, it should display "0" instead
//15) when user press "3.5" and "D", "displayLabel.text" should display "3", not "3."
//16) press "2, /, 3", "displayLabel.text" should equal to "0.666667"
//17) at least one UI test case for each one of the button in the calcualtor 

//TODO: Version control using git and github
//TODO: when divide by 0, "displayLabel.text" should display not a number

class CalculatorViewController: UIViewController {
    
    private var userIsInTheMiddleOfTyping = false
    private var brain = CalculatorBrain()
    
    
    private var displayedNumericalValue: Double? {
        get {
//            //displayLabel.text should never be nil and should never be a non number string. if it is, that means there is a bug, explicitly unwrapping it will cause the program to crash, which is what I want
//            return Double(displayLabel.text!)
            
            //TODO: should the number be rounded off in view controller, before it is used in the calculation? this will affect calculation precision, i think it is best that the result is rounded off, not the operand. But at the same time, the numbers shown in "calculationStepsLabel.text" is rounded off numbers, this means that the number used in calculation should be the rounded of number, because i think its good practice that what user sees is used in the calculation, instead of user see the rounded of number but the non-rounded number is used in the calculation 
            return Double.roundingOff(displayLabel.text!, decimalPlace: 6)
        }
        set {
            
            //create an instance of "NSNumberFormatter" where the max number of digit displayed after decimal point is 6 digit and min number of digit displayed before decimal point is 1 digit 
            //i guess a side effect of "formatter.maximumFractionDigits" is that it reduces calculation precision
            let formatter = NSNumberFormatter()
            formatter.maximumFractionDigits = 6
            formatter.minimumIntegerDigits = 1
            
            //TODO: is it safe to unwrap "newValue"?
            let stringRepresentationOfVariableNewValueUpToSixDecimalPlaces = formatter.stringFromNumber(newValue!)
            
            //TODO: is it safe to unwrap "stringRepresentationOfVariableNewValueUpToSixDecimalPlaces"?
            displayLabel.text = String(stringRepresentationOfVariableNewValueUpToSixDecimalPlaces!)
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
        
        // "if let displayedNumber = displayedNumericalValue {}" exist because we need to protect againest cases where "displayedNumericalValue" is equal to nil, which happens when "displayLabel.text" does not contain a string that can be converted to a number 
        if let displayedNumber = displayedNumericalValue {
        
            if userIsInTheMiddleOfTyping {
                userIsInTheMiddleOfTyping = false
                brain.setOperand(displayedNumber)
            }
            //use "if let" to check if "sender" contain a valid "currentTitle", because some "sender" can have empty string as "currentTitle"
            if let operation = sender.currentTitle {
                brain.performOperation(operation)
                
                //TODO: should "calculationStepsLabel.text = brain.description" come before or after "displayedNumericalValue = brain.result" or it doesnt matter
                //            calculationStepsLabel.text = brain.description
                calculationStepsLabel.text = brain.description + (brain.isPartialResult ? "..." : "=")
                
                //TODO: reasons on where to place "displayedNumericalValue = brain.result", inside or outside of "if let operation = sender.currentTitle {}"
                displayedNumericalValue = brain.result
                
            }
        } else {
            clearDataAndResetCalculator()
            displayLabel.text = "Not a number"
        }
    }
    
    //TODO: Should I treat clear button the same as all other operators or should I treat it differently, as a separate entity
    @IBAction func clearDataAndResetCalculator() {
        
        brain.clearAndResetToDefault()
        calculationStepsLabel.text = brain.description
        displayedNumericalValue = brain.result
        
        userIsInTheMiddleOfTyping = false 
        
    }
    
    //TODO: user pressed "5" and pressed "D", instead of displaying nothing at "displayLabel.text", should display "0"
    //TODO: user pressed "5, ., 6" and pressed "D", should display "5." at "displayLabel.text"
    //TODO: user pressed "5, ., 6" and pressed "D", should display "5." at "displayLabel.text", and pressed "+", should work at normal, as in "5." should work as "5"
    @IBAction private func deletePreviouslyEnteredDigit(sender: UIButton) {
        //"displayLabel.text" should always contain some number, whether it would be the number entered by the user or "0", therefore I'm force unwrapping it here
        var displayLabelText = displayLabel.text!
        _ = displayLabelText.removeAtIndex(displayLabelText.endIndex.predecessor())
        if displayLabelText.characters.count == 0 {
            displayLabel.text = "0"
            userIsInTheMiddleOfTyping = false 
        } else {
            displayLabel.text = displayLabelText
        }
        
    }
}

extension Double {
    
    private static func roundingOff(stringRepresentationOfADoubleValue: String, decimalPlace: Int) -> Double? {
        let formatter = NSNumberFormatter()
        if let value = formatter.numberFromString(stringRepresentationOfADoubleValue)?.doubleValue {
            return value.roundToPlace(value, decimalPlace: decimalPlace)
        } else {
            return nil
        }
    }
    
    private func roundToPlace(value: Double, decimalPlace: Int) -> Double {
        let divider = pow(10.0, Double(decimalPlace))
        let roundedNumber = round(value * divider) / divider
        return roundedNumber
    }
    
    
}

