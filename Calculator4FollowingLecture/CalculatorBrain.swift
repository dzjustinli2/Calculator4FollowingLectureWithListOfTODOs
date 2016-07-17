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
        "+" : Operation.BinaryOperation({ $0 + $1 }, { "\($0) + \($1)"} ),
        "-" : Operation.BinaryOperation ({ $0 - $1 }, {"\($0) - \($1)" }),
        "×" : Operation.BinaryOperation ({ $0 * $1 }, { "\($0) x \($1)" }),
        "÷" : Operation.BinaryOperation ({ $0 / $1 }, { "\($0) ÷ \($1)" }),
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
        descriptionAccumulator = String(operand)
    }
    
    func performOperation(symbol: String){
        
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
    }
}