//
//  ViewController.swift
//  Calculator
//
//  Created by Saroj Maharjan on 1/14/17.
//  Copyright © 2017 Luvah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    @IBOutlet private weak var operationDisplay: UILabel!
    
    private var userIsInTheMiddleOfTyping = false

    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if(userIsInTheMiddleOfTyping){
            let textCUrrentlyInDisplay = display.text!
            if(digit != "."){
            display.text = textCUrrentlyInDisplay+digit
            }else{
                if(rint(displayValue) == displayValue){
                    display.text = textCUrrentlyInDisplay+digit
                }else{
                    display.text = textCUrrentlyInDisplay
                }
            }
        }else{
            display.text = digit
        }
        operationDisplay.text = operationValue
        userIsInTheMiddleOfTyping = true;
    }
    
    private var displayValue : Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var operationValue : String{
        get{
            return brain.displayOperation
        }
        set{
            operationDisplay.text = newValue
        }
    }
    
    private var brain=CalculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if(userIsInTheMiddleOfTyping){
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathematicalSymbol)
        }
        operationDisplay.text = operationValue
        displayValue = brain.result
        
    }
}

