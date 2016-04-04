//
//  ConfigurationViewController.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 4/4/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let pickerExpressions = ["<", "<=", ">", ">=", "==", "!="]
    let pickerIncrementDecrement = ["++", "--"]
    let pickerMutations = ["+=", "-=", "*=", "/="]
    let pickerVariables = ["v1", "v2", "v3"]
    
    var pickerViewExpressions = UIPickerView()
    var pickerViewVariables = UIPickerView()
    var pickerViewMutations = UIPickerView()
    var pickerViewIncrementDecrement = UIPickerView()
    
    //if conditional
    @IBOutlet weak var ifConditionP1: UITextField!
    @IBOutlet weak var ifConditionP2: UITextField!
    
    //if body
    @IBOutlet weak var ifV1IncDec: UITextField!
    @IBOutlet weak var ifV2IncDec: UITextField!
    @IBOutlet weak var ifV3Mutation: UITextField!
    @IBOutlet weak var ifV3NumberField: UITextField!
    
    
    
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
        ifConditionP1.inputView = pickerViewExpressions
        ifConditionP2.inputView = pickerViewVariables
        ifV1IncDec.inputView = pickerViewIncrementDecrement
        ifV2IncDec.inputView = pickerViewIncrementDecrement
        ifV3Mutation.inputView = pickerViewMutations
        ifV3NumberField.inputView = pickerViewVariables
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Event Handling
    
    
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
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
