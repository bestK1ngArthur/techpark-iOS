//
//  Calculator.swift
//  test03
//
//  Created by Gennady Evstratov on 06/10/2016.
//  Copyright © 2016 test. All rights reserved.
//
// Класс управления операциями калькулятора

import Foundation

class Calculator {
    
    private struct PendingBinaryOperation {
        let firstOperand: Double
        let operation: ((Double, Double) -> Double)
    }
    
    private enum OperationType {
        case unary((Double) -> Double)
        case binary((Double, Double) -> Double)
        case equal
    }

    private var pendingOperation: PendingBinaryOperation? = nil
    
    private var accumulator: Double = 0
    
    private var operations: [String: OperationType] = [
        "∗": OperationType.unary({ $0*$0 }),
        "+/-": OperationType.unary({ -$0 }),
        "^": OperationType.binary({ pow($0, $1) }),
        "+": OperationType.binary({ $0 + $1 }),
        "-": OperationType.binary({ $0 - $1 }),
        "÷": OperationType.binary({ $0 / $1 }),
        "x": OperationType.binary({ $0 * $1 }),
        "=": OperationType.equal
    ]
    
    func setNumber(number: Double) {
        self.accumulator = number
    }
    
    func performOperation(operationString: String) -> Double {
        guard let operation = operations[operationString] else {
            return -1
        }
        
        switch operation {
        case .unary(let f):
            return f(accumulator)

        case .binary(let f):
            pendingOperation = PendingBinaryOperation(firstOperand: accumulator, operation: f)
            return accumulator
            
        case .equal:
            if let pending = pendingOperation {
                pendingOperation = nil
                return pending.operation(pending.firstOperand, accumulator)
            } else {
                return accumulator
            }
        }
    }
}
