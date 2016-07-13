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
        "√" : Operation.UnaryOperation( { sqrt($0) }, { "√(\($0))"} ),
        "+" : Operation.BinaryOperation( { $0 + $1}, { "\($0) + "} ),
//        "-" : Operation.BinaryOperation { $0 - $1},
//        "×" : Operation.BinaryOperation { $0 * $1},
//        "÷" : Operation.BinaryOperation { $0 / $1},
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        //TODO: what if I treat constants as numbers
        case Constant(Double)
        case UnaryOperation((Double) -> Double, (String) -> String)
        case BinaryOperation((Double, Double) -> Double, (String) -> String)
        case Equals
    }
    
    private var pending: PendingBinaryFunctionInfo?
    
    private struct PendingBinaryFunctionInfo {
        //TODO: should "binaryFunction" and "firstOperand" be declared as "let" or "var"?
        let binaryFunction: (Double, Double) -> Double
        let firstOperand: Double
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            //TODO: what if "pending" is not set to nil here, what will happen? (Something bad of course, but what kind of bad)
            pending = nil
        }
    }
    
    private var descriptionAccumulator: String = ""
    
    var description: String {
        return descriptionAccumulator
    }
    
    var isPartialResult: Bool {
        //TODO: should write "pending != nil" or "pending == nil"
        return pending != nil 
    }
    
    
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    func performOperation(symbol: String){
        if let operation = operationLookUp[symbol] {
            switch operation {
            case .Constant(let associatedConstantValue):
                accumulator = associatedConstantValue
            case .UnaryOperation(let unaryFunction, let unaryStringFunction):
                
                descriptionAccumulator = unaryStringFunction(String(accumulator))
                accumulator = unaryFunction(accumulator)
                
            case .BinaryOperation(let binaryFunction, let binaryStringFunction):
                
                descriptionAccumulator += binaryStringFunction(String(accumulator))
                
                executePendingBinaryOperation()
                pending = PendingBinaryFunctionInfo(binaryFunction: binaryFunction, firstOperand: accumulator)
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
}