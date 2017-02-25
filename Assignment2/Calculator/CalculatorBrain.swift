//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Saroj Maharjan on 1/14/17.
//  Copyright © 2017 Luvah. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    private var accumulator = 0.0
    private var currentOperationSymbol = ""
    var displayOperation = ""
    
    func setOperand(operand:Double){
        accumulator = operand
    }
    
    private var operations : Dictionary<String,Operation> = [
        "π":Operation.Constant(M_PI),
        "e":Operation.Constant(M_E),
        "√":Operation.UnaryOperation(sqrt), //sqrt,
        "cos":Operation.UnaryOperation(cos),
        "±" : Operation.UnaryOperation({-$0}),
        "×":Operation.BinaryOperation({$0*$1}),
        "+":Operation.BinaryOperation({$0+$1}),
        "-":Operation.BinaryOperation({$0-$1}),
        "÷":Operation.BinaryOperation({$0/$1}),
        "=":Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol:String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                displayOperation = symbol + "(" + String(accumulator) + ")"
                print("operation = \(displayOperation)")
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                currentOperationSymbol = symbol
                executePenidngBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePenidngBinaryOperation()
            }
        }
        
//        switch symbol {
//        case "π":
//            accumulator = M_PI
//        case "√":
//            accumulator = sqrt(accumulator)
//        default:
//            break
//        }
    }
    
    private func executePenidngBinaryOperation(){
        if pending != nil {
            displayOperation = String(pending!.firstOperand) + currentOperationSymbol + String(accumulator)
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            print("operation = \(displayOperation)")
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    var result:Double{
        get{
            return accumulator
        }
    }
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction:(Double,Double) -> Double
        var firstOperand:Double
    }
    
}
