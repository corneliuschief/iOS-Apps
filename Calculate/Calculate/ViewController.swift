//
//  ViewController.swift
//  Calculate
//
//  Created by Conor Forrest on 21/06/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel! {
        didSet {
            display.text = "0"
        }
    }
    
    //@IBOutlet weak var runningTotal: UILabel!
    @IBOutlet weak var enteredValuesSoFar: UILabel! {
        didSet {
            enteredValuesSoFar.text = "0"
        }
    }
    
    var valueOperatedOn: Double = 0
    var operatorUsed: String = ""
    var userIsTypingSomething = false
    private var brain = CalculatorBrain()
    let formatter = NumberFormatter()
    var lastOperator: String = ""
    var binaryOperandList: [String] = [
        "+", "-", "*", "÷"
    ]
    
    // Computed variables used to get and set from the display labels
    var displayValue: Double {
        get {
            return(Double(display.text!))!
        }
        set {
            
            //            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 15
            formatter.minimumIntegerDigits = 0
            display.text = formatter.string(from: NSNumber(value: newValue))
        }
        
        // old implementation            display.text = String(newValue)       }
    }
    
    var displayValueEntered: String {
        get {
            if let valuesEntered: String = enteredValuesSoFar.text {
                return valuesEntered
            }
            else {
                return ""
            }
        }
        set {
            enteredValuesSoFar.text = String(newValue)
        }
    }
    
    //    var displayValueRunning: Double {
    //        get {
    //            return(Double(runningTotal.text!))!
    //        }
    //        set {
    //            runningTotal.text = String(newValue)       }
    //    }
    
    // "C/CE" button which clears the displays and resets the accumulator
    // if display and entered values contain non-zeros; first press of the
    // button will clear the main display. Second press will clear the
    // entered values display also.
    @IBAction func ClearDisplay(_ sender: UIButton) {
        if lastOperator == "C/CE" {
            displayValueEntered = "0"
            lastOperator = ""
            valueOperatedOn = 0
        }
        else {
            lastOperator = "C/CE"
        }
        displayValue = 0
        brain.resetVars()
        userIsTypingSomething = false
    }
//        if let dVal = display.text {
            // If the main display is already cleared, clear the entered values display also
//            if dVal == "0" {
//                displayValueEntered = "0"
//                lastOperator = ""
//                valueOperatedOn = 0
                //               displayValueRunning = 0
//            }
//            else {
//                displayValue = 0
//            }
//        }
//        brain.resetVars()
//        userIsTypingSomething = false
//    }
    
    // When a user presses a number on the numberpad or "."
    @IBAction func NumberKeyPressed(_ sender: UIButton) {
        lastOperator = ""
        let digit: String = sender.currentTitle ?? "0"
        
        if enteredValuesSoFar.text == "0" || enteredValuesSoFar.text == "0.0" {
            enteredValuesSoFar.text = digit
            //            runningTotal.text = "0.0"
        }
        else{
            enteredValuesSoFar.text! += digit
        }
        
        // check if the digit is part of an entered sequence of numbers
        // or first of a sequence / standalone digit
        if userIsTypingSomething {
            
            // handle decimal input, prevent user from entering
            // more than one decimal point
            let currentTextInDisplay = display.text!
            if digit.contains(".") {
                if (currentTextInDisplay.contains(".")) {
                    return
                }
                else {
                    display.text! = currentTextInDisplay + digit
                }
            }
            else {
                display.text! = currentTextInDisplay + digit
            }
        }
        else {
            display.text = digit
            userIsTypingSomething = true
        }
    }
    
    // Called when an operator button is pressed
    @IBAction func PerformOperation(_ sender: UIButton) {
        
        // If user has already entered a number -> save the number
        if userIsTypingSomething {
            brain.setOperand(displayValue)
            userIsTypingSomething = false
        }
        
        // Perform the operation
        if let operation = sender.currentTitle {
            
            // binaryOperandList contains "+" "-" "*" and division sign
            if operation == lastOperator {
                if binaryOperandList.contains(operation) {
                    return
                }
            }
            
            if binaryOperandList.contains(operation) && binaryOperandList.contains(lastOperator) {
                return
            }
            
            brain.performOperation(operation)
            //appends the operator to the enteredValues
            if enteredValuesSoFar != nil && enteredValuesSoFar.text != "0"{
                enteredValuesSoFar.text! += operation
            }
                // Clear initial display of 0 when a constant is requested
            else if enteredValuesSoFar.text == "0" {
                if operation == "π" || operation == "e" {
                    enteredValuesSoFar.text! = operation
                }
            }
            lastOperator = operation
        }
        
        // If a result is returned from one of the operations
        // -> update the display and the entered values labels
        if let result = brain.result {
            if sender.currentTitle == "=" || sender.currentTitle == "x²" || sender.currentTitle == "√" {
                formatter.minimumFractionDigits = 0
                formatter.maximumFractionDigits = 15
                formatter.minimumIntegerDigits = 0
                let resultStr = formatter.string(from: NSNumber(value: result))
                // appends result of calculation to enteredValues surrounded by ()
                displayValueEntered = displayValueEntered + "(" + resultStr! + ")"
                
                //                displayValueEntered = displayValueEntered + "(" + String(result) + ")"
            }
            displayValue = result
            
            // displays the current calculated result in the running total display
            //            displayValueRunning = result
        }
    }
}
