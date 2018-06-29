//
//  CalculatorBrain.swift
//  Calculate
//
//  Created by Conor Forrest on 22/06/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//

import Foundation


struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
        
    }
    private var operations: Dictionary<String,operation> = [
        "+" : operation.binaryOperation({ $0 + $1 }),
        "-" : operation.binaryOperation({ $0 - $1 }),
        "*" : operation.binaryOperation({ $0 * $1 }),
        "÷" : operation.binaryOperation({ $0 / $1 }),
        "±" : operation.unaryOperation({ -$0 }),
        "sin" : operation.unaryOperation(sin),
        "cos" : operation.unaryOperation(cos),
        "tan" : operation.unaryOperation(tan),
        "x²" : operation.unaryOperation({ $0 * $0 }),
        "√" : operation.unaryOperation(sqrt),
        "=" : operation.equals,
        "π" : operation.constant(Double.pi),
        "e" : operation.constant(M_E)]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if pendingBinaryOperation != nil {
                    performPendingBinaryOperation()
                }
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    //                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
            
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func resetVars() {
        accumulator = nil
    }
    
    //read only calculated variable - read only because set method not defined
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
