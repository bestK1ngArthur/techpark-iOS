//
//  ViewController.swift
//  Calculator
//
//  Created by Artem Belkov on 11/10/2016.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var digitDisplay: UILabel!
    @IBOutlet weak var operatorDisplay: UILabel!
    
    private var userStartedTyping = false
    
    private let calculator = Calculator()
    
    var displayedNumber: Double {
        get {
            return Double(digitDisplay.text!) ?? Double(0)
        }
        
        set {
            digitDisplay.text = String(format: "%g", newValue)
            calculator.setNumber(number: newValue)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButtonPressed(nil)
    }
    
    @IBAction func resetButtonPressed(_ sender: AnyObject?) {
        digitDisplay.text = "0"
        operatorDisplay.text = ""
        userStartedTyping = false
        calculator.setNumber(number: displayedNumber)
    }
    
    @IBAction func operationButtonPressed(_ sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        
        guard let opString = button.currentTitle else {
            return
        }
        
        displayedNumber = calculator.performOperation(operationString: opString)
        operatorDisplay.text = opString
        userStartedTyping = false
    }
    
    @IBAction func numberButtonPressed(_ sender: AnyObject) {
        
        guard let button = sender as? UIButton else {
            return
        }
        
        guard let currentText = digitDisplay.text, let number = button.currentTitle else {
            return
        }
        
        if userStartedTyping {
            digitDisplay.text = currentText + number
        } else {
            digitDisplay.text = number
        }
        
        calculator.setNumber(number: displayedNumber)
        userStartedTyping = true
    }
    
    @IBAction func switchModeAction(_ sender: AnyObject) {
        self.digitDisplay.text = digitDisplay.text! + "."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

