//
//  ViewController.swift
//  Calculator
//
//  Created by Samuel Cole Morgan on 3/24/18.
//  Copyright © 2018 Samuel Cole Morgan. All rights reserved.
//


import UIKit


class ViewController: UIViewController {
    
    
    // set status bar style
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // global class variables
    
    var accumulator = ""
    var operand1 = ""
    var operand2 = ""
    var result = ""
    var InstantOperation = false
    var currentOperation:Operation = .nilCase
    
    
    // buttons and labels
    
    @IBOutlet weak var displayLabel: UILabel!
    
    @IBOutlet weak var multiplier: UIButton!
    @IBOutlet weak var subtractor: UIButton!
    @IBOutlet weak var adder: UIButton!
    @IBOutlet weak var divider: UIButton!
    @IBOutlet weak var equals: UIButton!
    @IBOutlet weak var dot: UIButton!
    @IBOutlet weak var clear: UIButton!
    
    
    // operation enumeration
    
    enum Operation:String {
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        case nilCase = "Nil"
    }
    
    
    // helper functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLabel.text = "0"
    }
    
    func resetCalculator() {
        displayLabel.text = "0"
        accumulator = ""
        operand1 = ""
        operand2 = ""
        result = ""
        InstantOperation = false
        currentOperation = .nilCase
    }
    
    func updateUILabel(_ num: Double) {
        if num.truncatingRemainder(dividingBy: 1) == 0 {
            displayLabel.text = "\(Int(num))"
        } else { displayLabel.text = "\(num)" }
    }
    
    
    // perform operation and generate result
    
    func operate(_ operation: Operation) {
        if currentOperation != .nilCase {
            if accumulator != "" {
                operand2 = accumulator
                accumulator = ""
                let double1 = Double(operand1)!
                let double2 = Double(operand2)!
                switch currentOperation {
                case .add:
                    result = "\(double1 + double2)"
                case .subtract:
                    result = "\(double1 - double2)"
                case .multiply:
                    result = "\(double1 * double2)"
                case .divide:
                    result = "\(double1 / double2)"
                default:
                    break
                }
                operand1 = result
                updateUILabel(Double(result)!)
            }
            currentOperation = operation
        } else {
            if InstantOperation == false && accumulator == "" {
                InstantOperation = true
                operand1 = "0"
            } else {
                operand1 = accumulator
                accumulator = ""
            }
            currentOperation = operation
        }
    }
    
    
    // handle button tap
    
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
            if isNumber != nil && accumulator.count <= 10 {
                accumulator += senderValue
                displayLabel.text = accumulator
            }
            break
        }
    }
    
    
}
