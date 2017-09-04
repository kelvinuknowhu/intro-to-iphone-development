//
//  ViewController.swift
//  Calculator
//
//  Created by Kelvin Hu on 9/4/17.
//  Copyright © 2017 Kelvin Hu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var numberOnScreen: Double = 0;
    var previousNumber: Double = 0;
    var performingMath = false;
    var decimalPressed = false;
    var equalSignPressed = false;
    var operation = 0;
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton)
    {
        if performingMath == true
        {
            if sender.tag == 10
            {
                label.text = "0"
            }
            else
            {
                label.text = String(sender.tag)
            }
            numberOnScreen = Double(label.text!)!
            performingMath = false
        }
        else
        {
            if sender.tag == 10 //0
            {
                if label.text != "0"
                {
                    label.text = label.text! + "0"
                }
            }
            else if sender.tag == 17 //Decimal
            {
                if !decimalPressed
                {
                    label.text = label.text! + "."
                    decimalPressed = true
                }
            }
            else //1-9
            {
                if label.text == "0"
                {
                    label.text = String(sender.tag)
                }
                else
                {
                    label.text = label.text! + String(sender.tag)
                }
            }
            numberOnScreen = Double(label.text!)!
        }
        
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16
        {
            if sender.tag == 12 // Divide pressed
            {
                previousNumber = numberOnScreen
                label.text = "÷"
                operation = sender.tag
                performingMath = true
                decimalPressed = false
                equalSignPressed = false
            }
            else if sender.tag == 13 //Multiply pressed
            {
                previousNumber = numberOnScreen
                label.text = "×"
                operation = sender.tag
                performingMath = true
                decimalPressed = false
                equalSignPressed = false
            }
            else if sender.tag == 14 //Minus presseed
            {
                previousNumber = numberOnScreen
                label.text = "–"
                operation = sender.tag
                performingMath = true
                decimalPressed = false
                equalSignPressed = false
            }
            else if sender.tag == 15 //Plus pressed
            {
                previousNumber = numberOnScreen
                label.text = "+"
                operation = sender.tag
                performingMath = true
                decimalPressed = false
                equalSignPressed = false
            }
            else if sender.tag == 18 //Inverse pressed
            {
                if label.text != "0"
                {
                    if numberOnScreen > 0
                    {
                        label.text = "– " + label.text!
                        numberOnScreen *= -1
                    }
                    else
                    {
                        let index = label.text!.index(label.text!.startIndex, offsetBy: 2)
                        label.text = label.text!.substring(from: index)
                        numberOnScreen *= -1
                    }
                }
                print("Previous: " + String(previousNumber) + " Now: " + String(numberOnScreen))
            }
            else if sender.tag == 19 //Percentage pressed
            {
                if numberOnScreen > 0
                {
                    numberOnScreen /= 100
                    label.text = String(numberOnScreen)
                }
                else if numberOnScreen < 0
                {
                    numberOnScreen /= 100
                    label.text = String(numberOnScreen)
                }
                print("Previous: " + String(previousNumber) + " Now: " + String(numberOnScreen))
            }
        }
        else if sender.tag == 16 //Equal pressed
        {
            if !equalSignPressed
            {
                equalSignPressed = true
                if operation == 12 //Divide computed
                {
                    let result: Double = previousNumber / numberOnScreen
                    label.text = resultToString(result)
                    previousNumber = numberOnScreen
                    numberOnScreen = result
                }
                else if operation == 13 //Multiply computed
                {
                    let result: Double = previousNumber * numberOnScreen
                    label.text = resultToString(result)
                    previousNumber = numberOnScreen
                    numberOnScreen = result
                }
                else if operation == 14 //Minus computed
                {
                    let result: Double = previousNumber - numberOnScreen
                    label.text = resultToString(result)
                    previousNumber = numberOnScreen
                    numberOnScreen = result
                }
                else if operation == 15 //Plus computed
                {
                    let result: Double = previousNumber + numberOnScreen
                    label.text = resultToString(result)
                    previousNumber = numberOnScreen
                    numberOnScreen = result
                }
            }
            else // equal sign has already been pressed
            {
                if operation == 12 //Divide recomputed
                {
                    let result: Double = numberOnScreen / previousNumber
                    label.text = resultToString(result)
                    numberOnScreen = result
                }
                else if operation == 13 //Multiply recomputed
                {
                    let result: Double = numberOnScreen * previousNumber
                    label.text = resultToString(result)
                    numberOnScreen = result
                }
                else if operation == 14 //Minus recomputed
                {
                    let result: Double = numberOnScreen - previousNumber
                    label.text = resultToString(result)
                    numberOnScreen = result
                }
                else if operation == 15 //Plus recomputed
                {
                    let result: Double = numberOnScreen + previousNumber
                    label.text = resultToString(result)
                    numberOnScreen = result
                }
            }
            print("Previous: " + String(previousNumber) + " Now: " + String(numberOnScreen))
        }
        else if sender.tag == 11 //Clear pressed
        {
            label.text = "0"
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
            performingMath = false;
            decimalPressed = false;
            equalSignPressed = false;
            print("Previous: " + String(previousNumber) + " Now: " + String(numberOnScreen))
        }
    }
    
    func isDoubleInteger(_ number: Double) -> Bool {
        let isInteger = floor(number) == number
        return isInteger
    }
    
    func resultToString(_ result: Double) -> String {
        if result >= 0
        {
            if isDoubleInteger(result)
            {
                return String(Int(result))
            }
            else
            {
                return String(result)
            }
        }
        else
        {
            if isDoubleInteger(result)
            {
                return "– " + String(Int(-result))
            }
            else
            {
                return "– " + String(-result)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

