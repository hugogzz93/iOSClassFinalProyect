//
//  ConfigurationViewController.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 4/4/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

/**
 View Controller that controls all the configuration
 for the execution of the For in the ViewControllerOne
 */

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
    var forV1IncDec: String = "++"
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
    var ifV1IncDec: String = "++"
    var ifV2IncDec: String = "--"
    var ifV3Mutation: String = "+="
    var ifV3NumberField: String = "v2"
    
    //nombre de variables
    var nombreV1: String = "v1"
    var nombreV2: String = "v2"
    var nombreV3: String = "v3"
    
    //variables activas/inactivas
    var actV2: Bool = true
    var actV3: Bool = true
    var actIF: Bool = true
    
}

class ConfigurationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var ForConfigHeader: ForHeader!
    
    let pickerExpressions = ["<", "<=", ">", ">=", "==", "!="]
    let pickerIncrementDecrement = ["++", "--", "+=2", "+=3"]
    let pickerIncrementDecrement2 = ["++", "--", "+=2","+=3", ""]
    let pickerMutations = ["+=", "-=", "*=", "/="]
    var pickerVariables = ["v1", "v2", "v3"]
    
    var pickerViewExpressions = UIPickerView()
    var pickerViewVariables = UIPickerView()
    var pickerViewMutations = UIPickerView()
    var pickerViewIncrementDecrement = UIPickerView()
    var pickerViewIncrementDecrement2 = UIPickerView()
    
    var tempNameV1 : String!
    var tempNameV2 : String!
    var tempNameV3 : String!

    var pastNameV1 : String!
    var pastNameV2 : String!
    var pastNameV3 : String!

    
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
    
    //cambio de nombre de variables
    @IBOutlet weak var cambioNombreV1: UITextField!
    @IBOutlet weak var cambioNombreV2: UITextField!
    @IBOutlet weak var cambioNombreV3: UITextField!
    
    //siwtches de control
    @IBOutlet weak var switchV2: UISwitch!
    @IBOutlet weak var switchV3: UISwitch!

    //  first responder
    var activeTextField = UITextField()
    
    func varNameChange(varUsed: String) -> String{
        switch varUsed {
        case tempNameV1:
            return cambioNombreV1.text!
        case tempNameV2:
            return cambioNombreV2.text!
        case tempNameV3:
            return cambioNombreV3.text!
        default:
            return varUsed
        }
    }
    
    func quitaV2(sender: UISwitch) {
        if !sender.on {
            refreshTextFieldsNoV2()
            cambioNombreV2.enabled = false
            cambioNombreV2.text = ""
            ForConfigHeader.actV2 = false
            pickerVariables = [ForConfigHeader.nombreV1, ForConfigHeader.nombreV3]
            switchV3.setOn(true, animated: true)
            quitaV3(switchV3)
        }
        else {
            cambioNombreV2.enabled = true
            ForConfigHeader.actV2 = true
            if cambioNombreV2.text == "" {
                cambioNombreV2.text = "v2"
                ForConfigHeader.nombreV2 = "v2"
            }
            pickerVariables = [ForConfigHeader.nombreV1, ForConfigHeader.nombreV2, ForConfigHeader.nombreV3]
        }
    }
    
    func quitaV3(sender: UISwitch) {
        if !sender.on {
            refreshTextFieldsNoV3()
            cambioNombreV3.enabled = false
            cambioNombreV3.text = ""
            ForConfigHeader.actV3 = false
            pickerVariables = [ForConfigHeader.nombreV1, ForConfigHeader.nombreV2]
            switchV2.setOn(true, animated: true)
            quitaV2(switchV2)
        }
        else {
            cambioNombreV3.enabled = true
            ForConfigHeader.actV3 = true
            if cambioNombreV3.text == "" {
                cambioNombreV3.text = "v3"
                ForConfigHeader.nombreV3 = "v3"
            }
            pickerVariables = [ForConfigHeader.nombreV1, ForConfigHeader.nombreV2, ForConfigHeader.nombreV3]
        }
        
    }
    
    func refreshTextFieldsNoV2() {
        if coutField1.text == ForConfigHeader.nombreV2  {
            dispatch_async(dispatch_get_main_queue(), {
                self.coutField1.text = self.ForConfigHeader.nombreV1})
        }
        if coutField2.text == ForConfigHeader.nombreV2  {
            dispatch_async(dispatch_get_main_queue(), {
                self.coutField2.text = self.ForConfigHeader.nombreV1})
        }
        if coutField3.text == ForConfigHeader.nombreV2  {
            dispatch_async(dispatch_get_main_queue(), {
                self.coutField3.text = self.ForConfigHeader.nombreV1})
        }
        if ifConditionP2.text == ForConfigHeader.nombreV2  {
            dispatch_async(dispatch_get_main_queue(), {
                self.ifConditionP2.text = self.ForConfigHeader.nombreV1})
        }
        if ifV3NumberField.text == ForConfigHeader.nombreV2  {
            dispatch_async(dispatch_get_main_queue(), {
                self.ifV3NumberField.text = self.ForConfigHeader.nombreV1})
        }
    }
    
    func refreshTextFieldsNoV3() {
        if coutField1.text == ForConfigHeader.nombreV3  {
            dispatch_async(dispatch_get_main_queue(), {
                self.coutField1.text = self.ForConfigHeader.nombreV1})
        }
        if coutField2.text == ForConfigHeader.nombreV3  {
            dispatch_async(dispatch_get_main_queue(), {
                self.coutField2.text = self.ForConfigHeader.nombreV1})
        }
        if coutField3.text == ForConfigHeader.nombreV3  {
            dispatch_async(dispatch_get_main_queue(), {
                self.coutField3.text = self.ForConfigHeader.nombreV1})
        }
        if ifConditionP2.text == ForConfigHeader.nombreV3  {
            dispatch_async(dispatch_get_main_queue(), {
                self.ifConditionP2.text = self.ForConfigHeader.nombreV1})
        }
        if ifV3NumberField.text == ForConfigHeader.nombreV3  {
            dispatch_async(dispatch_get_main_queue(), {
                self.ifV3NumberField.text = self.ForConfigHeader.nombreV1})
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        
        pickerVariables = [ForConfigHeader.nombreV1, ForConfigHeader.nombreV2, ForConfigHeader.nombreV3]
        cambioNombreV1.delegate = self
        cambioNombreV2.delegate = self
        cambioNombreV3.delegate = self
        
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
        
        //load past name
        cambioNombreV1.text = ForConfigHeader.nombreV1
        cambioNombreV2.text = ForConfigHeader.nombreV2
        cambioNombreV3.text = ForConfigHeader.nombreV3
        pastNameV1 = ForConfigHeader.nombreV1
        pastNameV2 = ForConfigHeader.nombreV2
        pastNameV3 = ForConfigHeader.nombreV3
        
        tempNameV1 = ForConfigHeader.nombreV1
        tempNameV2 = ForConfigHeader.nombreV2
        tempNameV3 = ForConfigHeader.nombreV3
        
        switchV2.setOn(ForConfigHeader.actV2, animated: true)
        switchV3.setOn(ForConfigHeader.actV3, animated: true)
        
        
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
        
        switchV2.addTarget(self, action: #selector(ConfigurationViewController.quitaV2(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        switchV3.addTarget(self, action: #selector(ConfigurationViewController.quitaV3(_:)), forControlEvents: UIControlEvents.ValueChanged)

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
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        
            if (!searchNum(mainV3.text!) || !searchNum(forInitV1P.text!) || !searchNum(forInitV2P.text!) || !searchNum(forInitV1NumberField.text!) || !searchNum(forV3NumberField.text!)) {
                
                let alertController = UIAlertController(title: "Error de Configuración", message: "No se colocaron números en las casillas correspondientes", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                }
                alertController.addAction(OKAction)
                
                self.presentViewController(alertController, animated: true, completion:nil)
                
                return false
            }
                
            else {
                refreshTextFieldsName(pastNameV1, num: 1)
                refreshTextFieldsName(pastNameV2, num: 2)
                refreshTextFieldsName(pastNameV3, num: 3)
                
                return true
            }
        }
        
        // by default, transition
  
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewInic: ViewControllerOne = segue.destinationViewController as! ViewControllerOne
        
        ForConfigHeader.mainV3 = Int(mainV3.text!)!
        
        //variable names
        ForConfigHeader.nombreV1 = cambioNombreV1.text!
        ForConfigHeader.nombreV2 = cambioNombreV2.text!
        ForConfigHeader.nombreV3 = cambioNombreV3.text!
        
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
        ForConfigHeader.ifConditionP2 = varNameChange(ifConditionP2.text!)
        
        //if body
        ForConfigHeader.ifV1IncDec = ifV1IncDec.text!
        ForConfigHeader.ifV2IncDec = ifV2IncDec.text!
        ForConfigHeader.ifV3Mutation = ifV3Mutation.text!
        ForConfigHeader.ifV3NumberField = ifV3NumberField.text!
        
        //variable active or inactive
        quitaV2(switchV2)
        quitaV3(switchV3)
        //ForConfigHeader.actIF = switchIF.on

        viewInic.forHeader = ForConfigHeader
        if ForConfigHeader.actV2 {
            if ForConfigHeader.actV3 {
                viewInic.currentView = 0
            }
            else {
                viewInic.currentView = 2
            }
        }
        else if ForConfigHeader.actV3 {
            viewInic.currentView = 1
        }
        else {
            viewInic.currentView = 0
        }
    }
    
    @IBAction func quitaTeclado()
    {
        self.view.endEditing(true)
    }
    

    func refreshTextFieldsName(nameV: String, num: NSNumber) {
        var temp : String!

        switch num {
        case 1:
            temp = cambioNombreV1.text
            break
        case 2:
            temp = cambioNombreV2.text
            break
        case 3:
            temp = cambioNombreV3.text
            break
        default:
            temp = cambioNombreV1.text
            break
        }
        
        if coutField1.text == nameV {
            self.coutField1.text = temp
        }
        if coutField2.text == nameV {
            self.coutField2.text = temp
        }
        if coutField3.text == nameV {
            self.coutField3.text = temp
        }
        if ifConditionP2.text == nameV {
            self.ifConditionP2.text = temp
        }
        if ifV3NumberField.text == nameV {
            self.ifV3NumberField.text = temp
        }
    
    }
    
    func searchNum(input : String) -> Bool{
        let numArray:[Character] = ["1", "2", "3","4", "5", "6","7", "8", "9","0"]
        var hayP : Bool = false
        
        if input.isEmpty {
            return false
        }
        
        for char in input.characters {
            for num in numArray {
                if char == num {
                    hayP = true
                }
            }
            if !hayP {
                return hayP
            }
            hayP=false
        }
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool
    {
        let maxLength = 4
        let currentString: NSString = textField.text!
        let newString: NSString =
            currentString.stringByReplacingCharactersInRange(range, withString: string)
        return newString.length <= maxLength
    }
}
