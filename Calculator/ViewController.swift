//
//  ViewController.swift
//  Calculator
//
//  Created by Samuel Cole Morgan on 3/24/18.
//  Copyright © 2018 Samuel Cole Morgan. All rights reserved.
//


import UIKit


class ViewController: UIViewController {
    
    //-------- Set Status Bar Color ---------
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //---------------------------------------
    
    
    //------- Global Class Variables -------
    
    var accumulator = ""
    var operand1 = ""
    var operand2 = ""
    var result = ""
    var currentOperation:Operation = .nilCase
    
    //---------------------------------------
    
    
    //------------ Enumerations -------------
    
    enum Operation:String {
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case nilCase = "Nil"
    }
    
    //---------------------------------------
    
    
    //--------------- UI Labels -------------
    
    @IBOutlet weak var displayLabel: UILabel!
    
    //---------------------------------------
    
    
    //--------------- Buttons ---------------
    
    @IBOutlet weak var multiplier: UIButton!
    @IBOutlet weak var subtractor: UIButton!
    @IBOutlet weak var adder: UIButton!
    @IBOutlet weak var divider: UIButton!
    @IBOutlet weak var equals: UIButton!
    @IBOutlet weak var dot: UIButton!
    @IBOutlet weak var clear: UIButton!
    
    //---------------------------------------
    
    
    //----- reset Main UI Label On Load -----
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    //---------------------------------------
    
    
    //---------- reset Calculator -----------
    
    func resetCalculator() {
        displayLabel.text = "0"
        accumulator = ""
        operand1 = ""
        operand2 = ""
        result = ""
        currentOperation = .nilCase
    }
    
    //---------------------------------------
    
    
    //-------- Determine  Operation ---------
    
    func operate(_ operation: Operation) {
        if currentOperation != .nilCase {
            if accumulator != "" {
                operand2 = accumulator
                accumulator = ""
                switch currentOperation {
                case .add:
                    result = "\(Double(operand1)! + Double(operand2)!)"
                case .subtract:
                    result = "\(Double(operand1)! - Double(operand2)!)"
                case .multiply:
                    result = "\(Double(operand1)! * Double(operand2)!)"
                case .divide:
                    result = "\(Double(operand1)! / Double(operand2)!)"
                default:
                    break
                }
                operand1 = result
                if Double(result)!.truncatingRemainder(dividingBy: 1) == 0 {
                    displayLabel.text = "\(Int(Double(result)!))"
                } else {
                    displayLabel.text = result
                }
            }
            currentOperation = operation
        } else {
            operand1 = accumulator
            accumulator = ""
            currentOperation = operation
        }
    }
    
    //---------------------------------------
    
    
    //----- Button Tap Handler function -----
    
    @IBAction func handleTap(_ sender: UIButton) {
        let senderValue = sender.titleLabel!.text!
        let isNumber: Int? = Int(senderValue)
        switch sender {
        case adder:
            operate(.add)
        case subtractor:
            operate(.subtract)
        case multiplier:
            operate(.multiply)
        case divider:
            operate(.divide)
        case equals:
            operate(currentOperation)
        case clear:
            resetCalculator()
        case dot:
            if accumulator.count <= 9 {
                accumulator += "."
                displayLabel.text = accumulator
            }
        default:
            if isNumber != nil {
                if accumulator.count <= 10 {
                    accumulator += senderValue
                    displayLabel.text = accumulator
                }
            }
            break
        }
    }
    
    //---------------------------------------
    
}
