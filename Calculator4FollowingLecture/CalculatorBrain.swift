//
//  CalculatorBrain.swift
//  Calculator4FollowingLecture
//
//  Created by justin on 10/07/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    private var accumulator = 0.0
    
    private var operationLookUp = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        
        "Rand" : Operation.NullOperation( {drand48()} ),
        
        "√" : Operation.UnaryOperation( { sqrt($0) }, { "√(\($0))"} ),
        "∛" : Operation.UnaryOperation( { pow($0, 1/3) }, { "∛(\($0))" }),
        "logₑ" : Operation.UnaryOperation({ log($0) / log(M_E) }, {"logₑ(\($0))"} ),
        //FIXME: press "100" and "log₁₀" should make "displayLabel.text" equal to 2, had to add "log(10)" to "log($0) / log(10)" to make it work as expected, but I thought just having "log(100)" is equal to "log₁₀(100)" should work just fine. Find out why
        "log₁₀": Operation.UnaryOperation( { log($0) / log(10) }, { "log₁₀(\($0))" }),
        "eⁿ" : Operation.UnaryOperation({ pow(M_E, $0) }, { "e^\($0)" } ),
        "10ⁿ" : Operation.UnaryOperation( { pow(10.0, $0) }, { "10^\($0)" } ),
        "x³" : Operation.UnaryOperation( { pow($0, 3.0) }, { "\($0)^3" }),
        "x²" : Operation.UnaryOperation( { pow($0, 2.0) }, { "\($0)^2" }),
        "1/x" : Operation.UnaryOperation( { 1 / $0 }, { "1÷\($0)" }),
        "sin" : Operation.UnaryOperation( { sin($0) }, { "sin\($0)" }),
        "cos" : Operation.UnaryOperation( { cos($0) }, { "cos\($0)" }),
        "tan" : Operation.UnaryOperation( { tan($0) }, { "tan\($0)" }),
        
        "+" : Operation.BinaryOperation({ $0 + $1 }, { "\($0) + \($1)"} ),
        "-" : Operation.BinaryOperation ({ $0 - $1 }, {"\($0) - \($1)" }),
        "×" : Operation.BinaryOperation ({ $0 * $1 }, { "\($0) × \($1)" }),
        "÷" : Operation.BinaryOperation ({ $0 / $1 }, { "\($0) ÷ \($1)" }),
        "%" : Operation.BinaryOperation( {$0 % $1 }, {"\($0) % \($1)"} ),
        "xⁿ" : Operation.BinaryOperation( { pow($0, $1) }, { "\($0)^\($1)" } ),
        "EE" : Operation.BinaryOperation( { $0 * (pow(10.0, $1)) }, { "\($0) × 10^\($1)" }),
        //TODO: did NOT implement functions for "sinh", "cosh", "tanh" button because I dont know what they do.....😓.....and also I love IT!! its so freaking amazing!!
        
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        //TODO: what if I treat constants as numbers
        case Constant(Double)
        case NullOperation(() -> Double)
        case UnaryOperation((Double) -> Double, (String) -> String)
        case BinaryOperation((Double, Double) -> Double, (String, String) -> String)
        case Equals
    }
    
    private var pending: PendingBinaryFunctionInfo?
    
    private struct PendingBinaryFunctionInfo {
        //TODO: should "binaryFunction" and "firstOperand" be declared as "let" or "var"?
        let binaryFunction: (Double, Double) -> Double
        let firstOperand: Double
        let binaryStringFunction: (String, String) -> String
        let firstStringOperand: String
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            descriptionAccumulator = pending!.binaryStringFunction(pending!.firstStringOperand, descriptionAccumulator)
            
            //TODO: what if "pending" is not set to nil here, what will happen? (Something bad of course, but what kind of bad)
            pending = nil
        }
    }
    
    //use with a space in between i.e. " ", not without space, "", because for if UILabel's text is equal to "", its size will be 0, 0, and disappear from user interface
    private var descriptionAccumulator: String = " "
    
    var description: String {
        get {
            if pending == nil {
                return descriptionAccumulator
            } else {
                return pending!.binaryStringFunction(pending!.firstStringOperand, pending!.firstStringOperand != descriptionAccumulator ? descriptionAccumulator : "")
            }

        }
    }
    
    
    var isPartialResult: Bool {
        //TODO: should write "pending != nil" or "pending == nil"
        return pending != nil 
    }
    
    
    
    func setOperand(operand: Double){
        accumulator = operand
        internalProgram.append(operand)
        
        //TODO: too many lines of code just to remove the trailing zero of "operand"
        let formatter = NSNumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        formatter.minimumIntegerDigits = 1
        if let stringOfOperandWithNoTrailingZero = formatter.stringFromNumber(operand) {
            
            descriptionAccumulator = stringOfOperandWithNoTrailingZero
        } else {
            descriptionAccumulator = String(operand)
        }
    }
    
    func performOperation(symbol: String){
        internalProgram.append(symbol)
        
        if let operation = operationLookUp[symbol] {
            switch operation {
            case .Constant(let associatedConstantValue):
                
                descriptionAccumulator = symbol
                accumulator = associatedConstantValue
                
            case .NullOperation(let nullFunction):
                
                //unlike ".UnaryOperation", here at ".NullOperation", we have to assign to "accumulator" first and then assign to "descriptionAccumulator", because the "accumulator" is not changed by the "nullFunction()" and also because we need to convert "accumulator" to "descriptionAccumulator". Whereas in the ".UnaryOperation", the order of assinging new values to "accumulator" and "descriptionAccumulator" does not matter 
                accumulator = nullFunction()
                descriptionAccumulator = String(accumulator)
                
            case .UnaryOperation(let unaryFunction, let unaryStringFunction):
                
                descriptionAccumulator = unaryStringFunction(descriptionAccumulator)
                
                accumulator = unaryFunction(accumulator)
                
            case .BinaryOperation(let binaryFunction, let binaryStringFunction):
                
                executePendingBinaryOperation()
                pending = PendingBinaryFunctionInfo(
                    binaryFunction: binaryFunction,
                    firstOperand: accumulator,
                    binaryStringFunction: binaryStringFunction,
                    firstStringOperand: descriptionAccumulator
                )
                
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    func clearAndResetToDefault(){
        pending = nil
        accumulator = 0
        descriptionAccumulator = " "
        internalProgram.removeAll()
    }
    
    private var internalProgram = [AnyObject]()
    
    typealias PropertyList = AnyObject
    
    var program: PropertyList {
        get {
            //because "internalProgram" is a variable of struct type, therefore we are returning here a copy of "internalProgram", not a pointer to our internal implementation of "internalProgram"
            return internalProgram
        }
        set {
            clearAndResetToDefault()
            if let ops = newValue as? [AnyObject]{
                for op in ops {
                    if let operand = op as? Double {
                        setOperand(operand)
                    } else if let operation = op as? String {
                        performOperation(operation)
                    }
                    
                }
            }
        }
    }
}