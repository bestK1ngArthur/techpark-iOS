//
//  ViewController.swift
//  Calculator
//
//  Created by Artem Belkov on 11/10/2016.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var display: UILabel!
    
    private var userStartedTyping = false
    
    private let calculator = Calculator()
    
    var displayedNumber: Double {
        get {
            return Double(display.text!) ?? Double(0)
        }
        
        set {
            display.text = String(format: "%g", newValue)
            calculator.setNumber(number: newValue)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func resetButtonPressed(_ sender: AnyObject) {
        display.text = "0"
        userStartedTyping = false
        calculator.setNumber(number: displayedNumber)
    }
    
    @IBAction func operationButtonPressed(_ sender: AnyObject) {
        
        guard let button = sender as? UIButton else {
            return
        }
        
        guard let op = button.currentTitle else {
            return
        }
        
        displayedNumber = calculator.performOperation(operation: op)
        userStartedTyping = false
    }
    
    @IBAction func numberButtonPressed(_ sender: AnyObject) {
        
        guard let button = sender as? UIButton else {
            return
        }
        
        guard let currentText = display.text, let number = button.currentTitle else {
            return
        }
        
        if userStartedTyping {
            display.text = currentText + number
        } else {
            display.text = number
        }
        
        calculator.setNumber(number: displayedNumber)
        userStartedTyping = true
    }
    
    @IBAction func switchModeAction(_ sender: AnyObject) {
        self.display.text = display.text! + "."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

