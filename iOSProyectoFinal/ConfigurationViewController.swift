//
//  ConfigurationViewController.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 4/4/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

struct ForHeader {
    
    var mainV3: Int
    
    
    //for init
    var forInitV1P: Int
    var forInitV2P: Int
    
    var forInitV1Condition: String
    var forInitV1NumberField: Int
    
    var forInitV1IncDec: String
    var forInitV2IncDec: String
    
    //for body
    var forV1IncDec: String
    var forV2IncDec: String
    var forV3Mutation: String
    var forV3NumberField: Int
    
    var coutField1: String
    var coutField2: String
    var coutField3: String
    
    //if conditional
    var ifConditionP1: String
    var ifConditionP2: String
    
    //if body
    var ifV1IncDec: String
    var ifV2IncDec: String
    var ifV3Mutation: String
    var ifV3NumberField: Int
    
}

class ConfigurationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var ForConfigHeader: ForHeader!
    
    let pickerExpressions = ["<", "<=", ">", ">=", "==", "!="]
    let pickerIncrementDecrement = ["++", "--"]
    let pickerMutations = ["+=", "-=", "*=", "/="]
    let pickerVariables = ["v1", "v2", "v3"]
    
    var pickerViewExpressions = UIPickerView()
    var pickerViewVariables = UIPickerView()
    var pickerViewMutations = UIPickerView()
    var pickerViewIncrementDecrement = UIPickerView()
    
    @IBOutlet weak var mainV3: UITextField!
    
    
    //for init
    @IBOutlet weak var forInitV1P: UITextField!
    @IBOutlet weak var forInitV2P: UITextField!
    
    @IBOutlet weak var forInitV1Condition: UITextField!
    @IBOutlet weak var forInitV1NumberField: UITextField!
    
    @IBOutlet weak var forInitV1IncDec: UITextField!
    @IBOutlet weak var forInitV2IncDec: UITextField!
    
    //for body
    @IBOutlet weak var forV1IncDec: UITextField!
    @IBOutlet weak var forV2IncDec: UITextField!
    @IBOutlet weak var forV3Mutation: UITextField!
    @IBOutlet weak var forV3NumberField: UITextField!
    
    @IBOutlet weak var coutField1: UITextField!
    @IBOutlet weak var coutField2: UITextField!
    @IBOutlet weak var coutField3: UITextField!
    
    //if conditional
    @IBOutlet weak var ifConditionP1: UITextField!
    @IBOutlet weak var ifConditionP2: UITextField!
    
    //if body
    @IBOutlet weak var ifV1IncDec: UITextField!
    @IBOutlet weak var ifV2IncDec: UITextField!
    @IBOutlet weak var ifV3Mutation: UITextField!
    @IBOutlet weak var ifV3NumberField: UITextField!

    //  first responder
    var activeTextField = UITextField()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        pickerView protocols
        pickerViewExpressions.delegate = self
        pickerViewExpressions.dataSource = self
        
        pickerViewVariables.delegate = self
        pickerViewVariables.dataSource = self
        
        pickerViewMutations.delegate = self
        pickerViewMutations.dataSource = self
        
        pickerViewIncrementDecrement.delegate = self
        pickerViewIncrementDecrement.dataSource = self
        
//          picker view identification
        pickerViewExpressions.tag = 0
        pickerViewVariables.tag = 1
        pickerViewIncrementDecrement.tag = 2
        pickerViewMutations.tag = 3
        
//          pickerView assignment
        forInitV1Condition.inputView = pickerViewExpressions
        forInitV1IncDec.inputView = pickerViewIncrementDecrement
        forInitV2IncDec.inputView = pickerViewIncrementDecrement
        forV1IncDec.inputView = pickerViewIncrementDecrement
        forV2IncDec.inputView = pickerViewIncrementDecrement
        forV3Mutation.inputView = pickerViewMutations
        
        ifConditionP1.inputView = pickerViewExpressions
        ifConditionP2.inputView = pickerViewVariables
        ifV1IncDec.inputView = pickerViewIncrementDecrement
        ifV2IncDec.inputView = pickerViewIncrementDecrement
        ifV3Mutation.inputView = pickerViewMutations
        ifV3NumberField.inputView = pickerViewVariables
        
        coutField1.inputView = pickerViewVariables
        coutField2.inputView = pickerViewVariables
        coutField3.inputView = pickerViewVariables
        
        
        
//        textfieldDelegation
        forInitV1Condition.delegate = self
        forInitV1IncDec.delegate = self
        forInitV2IncDec.delegate = self
        forV1IncDec.delegate = self
        forV2IncDec.delegate = self
        forV3Mutation.delegate = self
        
        ifConditionP1.delegate = self
        ifConditionP2.delegate = self
        ifV1IncDec.delegate = self
        ifV2IncDec.delegate = self
        ifV3Mutation.delegate = self
        ifV3NumberField.delegate = self
        
        coutField1.delegate = self
        coutField2.delegate = self
        coutField3.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Event Handling
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        self.activeTextField = textField
    }
    
    
    // MARK: - PickerView
    
    // returns the number of 'columns' to display.
    @available(iOS 2.0, *)
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    @available(iOS 2.0, *)
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return pickerExpressions.count
        } else if pickerView.tag == 1 {
            return pickerVariables.count
        } else if pickerView.tag == 2 {
            return pickerIncrementDecrement.count
        } else if pickerView.tag == 3 {
            return pickerMutations.count
        }
        return 1
        
    }
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            return pickerExpressions[row]
        } else if pickerView.tag == 1 {
            return pickerVariables[row]
        } else if pickerView.tag == 2 {
            return pickerIncrementDecrement[row]
        } else if pickerView.tag == 3 {
            return pickerMutations[row]
        }
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var text = ""
        
        if pickerView.tag == 0 {
            text = pickerExpressions[row]
        } else if pickerView.tag == 1 {
            text = pickerVariables[row]
        } else if pickerView.tag == 2 {
            text = pickerIncrementDecrement[row]
        } else if pickerView.tag == 3 {
            text = pickerMutations[row]
        }
        
        
        activeTextField.text = text
    }
    
    

     // MARK: - Navigation

 
    
}
