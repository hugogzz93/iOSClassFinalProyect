//
//  ConfigurationViewController.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 4/4/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

struct ForHeader {
    
    var mainV3: Int = 3
    
    
    //for init
    var forInitV1P: Int = 1
    var forInitV2P: Int = 2
    
    var forInitV1Condition: String =  "<"
    var forInitV1NumberField: Int = 10
    
    var forInitV1IncDec: String = "++"
    var forInitV2IncDec: String = "--"
    
    //for body
    var forV1IncDec: String = "--"
    var forV2IncDec: String = "++"
    var forV3Mutation: String = "-="
    var forV3NumberField: Int = 2
    
    var coutField1: String = "v1"
    var coutField2: String = "v2"
    var coutField3: String = "v3"
    
    //if conditional
    var ifConditionP1: String = ">="
    var ifConditionP2: String = "v2"
    
    //if body
    var ifV1IncDec: String = "+="
    var ifV2IncDec: String = "--"
    var ifV3Mutation: String = "+="
    var ifV3NumberField: String = "v2"
    //var ifV3NumberField: Int = 2
    
}

class ConfigurationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var ForConfigHeader: ForHeader!
    
    let pickerExpressions = ["<", "<=", ">", ">=", "==", "!="]
    let pickerIncrementDecrement = ["++", "--"]
    let pickerIncrementDecrement2 = ["++", "--",""]
    let pickerMutations = ["+=", "-=", "*=", "/="]
    let pickerVariables = ["v1", "v2", "v3"]
    
    var pickerViewExpressions = UIPickerView()
    var pickerViewVariables = UIPickerView()
    var pickerViewMutations = UIPickerView()
    var pickerViewIncrementDecrement = UIPickerView()
    var pickerViewIncrementDecrement2 = UIPickerView()
    
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
        self.hideKeyboardWhenTappedAround() 
        mainV3.text = String(ForConfigHeader.mainV3)
        
        forInitV1P.text = String(ForConfigHeader.forInitV1P)
        forInitV2P.text = String(ForConfigHeader.forInitV2P)
        forInitV1Condition.text = ForConfigHeader.forInitV1Condition
        forInitV1NumberField.text = String(ForConfigHeader.forInitV1NumberField)
        forInitV1IncDec.text = ForConfigHeader.forInitV1IncDec
        forInitV2IncDec.text = ForConfigHeader.forInitV2IncDec
        
        ifConditionP1.text = ForConfigHeader.ifConditionP1
        ifConditionP2.text = ForConfigHeader.ifConditionP2
        ifV1IncDec.text = ForConfigHeader.ifV1IncDec
        ifV2IncDec.text = ForConfigHeader.ifV2IncDec
        ifV3Mutation.text = ForConfigHeader.ifV3Mutation
        ifV3NumberField.text = String(ForConfigHeader.ifV3NumberField)
        
        forV1IncDec.text = ForConfigHeader.forV1IncDec
        forV2IncDec.text = ForConfigHeader.forV2IncDec
        forV3Mutation.text = ForConfigHeader.forV3Mutation
        forV3NumberField.text = String(ForConfigHeader.forV3NumberField)
        coutField1.text = ForConfigHeader.coutField1
        coutField2.text = ForConfigHeader.coutField2
        coutField3.text = ForConfigHeader.coutField3
        
        
//        pickerView protocols
        pickerViewExpressions.delegate = self
        pickerViewExpressions.dataSource = self
        
        pickerViewVariables.delegate = self
        pickerViewVariables.dataSource = self
        
        pickerViewMutations.delegate = self
        pickerViewMutations.dataSource = self
        
        pickerViewIncrementDecrement.delegate = self
        pickerViewIncrementDecrement.dataSource = self
        
        pickerViewIncrementDecrement2.delegate = self
        pickerViewIncrementDecrement2.dataSource = self
        
//          picker view identification
        pickerViewExpressions.tag = 0
        pickerViewVariables.tag = 1
        pickerViewIncrementDecrement.tag = 2
        pickerViewMutations.tag = 3
        pickerViewIncrementDecrement2.tag = 4
        
//          pickerView assignment
        forInitV1Condition.inputView = pickerViewExpressions
        forInitV1IncDec.inputView = pickerViewIncrementDecrement
        forInitV2IncDec.inputView = pickerViewIncrementDecrement2
        forV1IncDec.inputView = pickerViewIncrementDecrement
        forV2IncDec.inputView = pickerViewIncrementDecrement2
        forV3Mutation.inputView = pickerViewMutations
        
        ifConditionP1.inputView = pickerViewExpressions
        ifConditionP2.inputView = pickerViewVariables
        ifV1IncDec.inputView = pickerViewIncrementDecrement
        ifV2IncDec.inputView = pickerViewIncrementDecrement2
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
        } else if pickerView.tag == 4 {
            return pickerIncrementDecrement2.count
        }
        return 1
        
    }
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 0 {
            self.activeTextField.text = pickerExpressions[row]
            return pickerExpressions[row]
        } else if pickerView.tag == 1 {
            self.activeTextField.text = pickerVariables[row]
            return pickerVariables[row]
        } else if pickerView.tag == 2 {
            self.activeTextField.text = pickerIncrementDecrement[row]
            return pickerIncrementDecrement[row]
        } else if pickerView.tag == 3 {
            self.activeTextField.text = pickerMutations[row]
            return pickerMutations[row]
        }else if pickerView.tag == 4 {
            self.activeTextField.text = pickerIncrementDecrement2[row]
            return pickerIncrementDecrement2[row]
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
        }else if pickerView.tag == 4 {
            text = pickerIncrementDecrement2[row]
        }
        
        activeTextField.text = text
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewInic: ViewControllerOne = segue.destinationViewController as! ViewControllerOne
        
        ForConfigHeader.forInitV1P = Int(forInitV1P.text!)!
        ForConfigHeader.forInitV2P = Int(forInitV2P.text!)!
        ForConfigHeader.forInitV1Condition = forInitV1Condition.text!
        ForConfigHeader.forInitV1NumberField = Int(forInitV1NumberField.text!)!
        ForConfigHeader.forInitV1IncDec = forInitV1IncDec.text!
        ForConfigHeader.forInitV2IncDec = forInitV2IncDec.text!
        
        ForConfigHeader.forV1IncDec = forV1IncDec.text!
        ForConfigHeader.forV2IncDec = forV2IncDec.text!
        ForConfigHeader.forV3Mutation = forV3Mutation.text!
        ForConfigHeader.forV3NumberField = Int(forV3NumberField.text!)!
        
        ForConfigHeader.coutField1 = coutField1.text!
        ForConfigHeader.coutField2 = coutField2.text!
        ForConfigHeader.coutField3 = coutField3.text!
        
        //if conditional
        ForConfigHeader.ifConditionP1 = ifConditionP1.text!
        ForConfigHeader.ifConditionP2 = ifConditionP2.text!
        
        //if body
        ForConfigHeader.ifV1IncDec = ifV1IncDec.text!
        ForConfigHeader.ifV2IncDec = ifV2IncDec.text!
        ForConfigHeader.ifV3Mutation = ifV3Mutation.text!
        ForConfigHeader.ifV3NumberField = ifV3NumberField.text!
        //ForConfigHeader.ifV3NumberField = Int(ifV3NumberField.text!)!

        
        viewInic.forHeader = ForConfigHeader
    }
    
    @IBAction func quitaTeclado()
    {
        self.view.endEditing(true)
    }

    
    

     // MARK: - Navigation

 
    
}
