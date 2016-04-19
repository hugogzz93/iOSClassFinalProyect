//
//  ViewControllerOne.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 3/9/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController {
    
    var forHeader = ForHeader(
        mainV3: 3,
        forInitV1P: 1,
        forInitV2P: 2,
        
        forInitV1Condition: "<",
        forInitV1NumberField: 10,
        forInitV1IncDec: "++",
        forInitV2IncDec: "--",
        forV1IncDec: "--",
        forV2IncDec: "++",
        forV3Mutation: "-=",
        forV3NumberField: 2,
        coutField1: "v1",
        coutField2: "v2",
        coutField3: "v3",
        ifConditionP1: ">=",
        ifConditionP2: "v2",
        ifV1IncDec: "++",
        ifV2IncDec: "--",
        ifV3Mutation: "+=",
        ifV3NumberField: "v2",
        nombreV1: "v1",
        nombreV2: "v2",
        nombreV3: "v3",
        actV2:  true,
        actV3:  true
    )
    
    
    @IBOutlet weak var mainV3: UITextField!
    
    
    //for init
    @IBOutlet weak var forInitV1P: UITextField!
    @IBOutlet weak var forInitV2P: UITextField!
    
    @IBOutlet weak var forInitV1Condition: UITextField!
    @IBOutlet weak var forInitV1NumberField: UITextField!
    
    @IBOutlet weak var forInitV1IncDec: UITextField!
    @IBOutlet weak var forInitV2IncDec: UITextField!
    
    
    @IBOutlet weak var endInitV1: UILabel!
    @IBOutlet weak var endInitV2: UILabel!
    @IBOutlet weak var endPar1: UILabel!
    @IBOutlet weak var endPar2: UILabel!
    
    
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
    
    //variable names labels
    
    @IBOutlet weak var v3start: UILabel!
    
    @IBOutlet weak var v1ForDec: UILabel!
    @IBOutlet weak var v2ForDec: UILabel!
    @IBOutlet weak var v1ForCompare: UILabel!
    @IBOutlet weak var v1ForCambio: UILabel!
    @IBOutlet weak var v2ForCambio: UILabel!
    
    @IBOutlet weak var v1ForBody: UILabel!
    @IBOutlet weak var v2ForBody: UILabel!
    @IBOutlet weak var v3ForBody: UILabel!
    
    @IBOutlet weak var ifV1Compare: UILabel!
    @IBOutlet weak var v1IF: UILabel!
    @IBOutlet weak var v2IF: UILabel!
    @IBOutlet weak var v3IF: UILabel!
    
    @IBOutlet weak var v1Inspect: UILabel!
    @IBOutlet weak var v2Inspect: UILabel!
    @IBOutlet weak var v3Inspect: UILabel!
    
    @IBOutlet weak var v2InspectVal: UILabel!
    @IBOutlet weak var v3InspectVal: UILabel!
    
    @IBOutlet weak var v2InspectOutput: UILabel!
    @IBOutlet weak var v3InspectOutput: UILabel!
    
    @IBOutlet weak var v1Correct: UILabel!
    @IBOutlet weak var v2Correct: UILabel!
    @IBOutlet weak var v3Correct: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mainV3.text = String(forHeader.mainV3)
        forInitV1P.text = String(forHeader.forInitV1P)
        forInitV2P.text = String(forHeader.forInitV2P)
        forInitV1Condition.text = forHeader.forInitV1Condition
        forInitV1NumberField.text = String(forHeader.forInitV1NumberField)
        forInitV1IncDec.text = forHeader.forV1IncDec
        forInitV2IncDec.text = forHeader.forV2IncDec
        
        forV1IncDec.text = forHeader.forV1IncDec
        forV2IncDec.text = forHeader.forV2IncDec
        forV3Mutation.text = forHeader.forV3Mutation
        forV3NumberField.text = String(forHeader.forV3NumberField)
        coutField1.text = forHeader.coutField1
        coutField2.text = forHeader.coutField2
        coutField3.text = forHeader.coutField3
        
        ifConditionP1.text = forHeader.ifConditionP1
        ifConditionP2.text = forHeader.ifConditionP2
        ifV1IncDec.text = forHeader.ifV1IncDec
        ifV2IncDec.text = forHeader.ifV2IncDec
        ifV3Mutation.text = forHeader.ifV3Mutation
        ifV3NumberField.text = String(forHeader.ifV3NumberField)
        
        //variable name load
        v3start.text = "int "+forHeader.nombreV3+" ="
        v1ForDec.text = "for ( int "+forHeader.nombreV1+"=  "
        v2ForDec.text = "int "+forHeader.nombreV2+" ="
        v1ForCompare.text = forHeader.nombreV1
        v1ForCambio.text = forHeader.nombreV1
        v2ForCambio.text = forHeader.nombreV2
        v1ForBody.text = forHeader.nombreV1
        v2ForBody.text = forHeader.nombreV2
        v3ForBody.text = forHeader.nombreV3
        ifV1Compare.text = "if ("+forHeader.nombreV1
        v1IF.text = forHeader.nombreV1
        v2IF.text = forHeader.nombreV2
        v3IF.text = forHeader.nombreV3
        v1Inspect.text = forHeader.nombreV1
        v2Inspect.text = forHeader.nombreV2
        v3Inspect.text = forHeader.nombreV3
        v1Correct.text = forHeader.nombreV1
        v2Correct.text = forHeader.nombreV2
        v3Correct.text = forHeader.nombreV3
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindEditar(sender: UIStoryboardSegue){
        mainV3.text = String(forHeader.mainV3)
        forInitV1P.text = String(forHeader.forInitV1P)
        forInitV2P.text = String(forHeader.forInitV2P)
        forInitV1Condition.text = forHeader.forInitV1Condition
        forInitV1NumberField.text = String(forHeader.forInitV1NumberField)
        forInitV1IncDec.text = forHeader.forInitV1IncDec
        forInitV2IncDec.text = forHeader.forInitV2IncDec
        
        forV1IncDec.text = forHeader.forV1IncDec
        forV2IncDec.text = forHeader.forV2IncDec
        forV3Mutation.text = forHeader.forV3Mutation
        forV3NumberField.text = String(forHeader.forV3NumberField)
        coutField1.text = forHeader.coutField1
        coutField2.text = forHeader.coutField2
        coutField3.text = forHeader.coutField3
        
        ifConditionP1.text = forHeader.ifConditionP1
        ifConditionP2.text = forHeader.ifConditionP2
        ifV1IncDec.text = forHeader.ifV1IncDec
        ifV2IncDec.text = forHeader.ifV2IncDec
        ifV3Mutation.text = forHeader.ifV3Mutation
        ifV3NumberField.text = String(forHeader.ifV3NumberField)
        
        //variable name load
        v3start.text = "int "+forHeader.nombreV3+" ="
        v1ForDec.text = "for ( int "+forHeader.nombreV1+"=  "
        v2ForDec.text = "int "+forHeader.nombreV2+" ="
        v1ForCompare.text = forHeader.nombreV1
        v1ForCambio.text = forHeader.nombreV1
        v2ForCambio.text = forHeader.nombreV2
        v1ForBody.text = forHeader.nombreV1
        v2ForBody.text = forHeader.nombreV2
        v3ForBody.text = forHeader.nombreV3
        ifV1Compare.text = "if ("+forHeader.nombreV1
        v1IF.text = forHeader.nombreV1
        v2IF.text = forHeader.nombreV2
        v3IF.text = forHeader.nombreV3
        v1Inspect.text = forHeader.nombreV1
        v2Inspect.text = forHeader.nombreV2
        v3Inspect.text = forHeader.nombreV3
        v1Correct.text = forHeader.nombreV1
        v2Correct.text = forHeader.nombreV2
        v3Correct.text = forHeader.nombreV3
        
        
        checkActVar()
        
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "config"{
            let viewConfig: ConfigurationViewController = segue.destinationViewController as! ConfigurationViewController
            viewConfig.ForConfigHeader = forHeader
            
        }
    }
    
    func checkActVar() {
        if !forHeader.actV2 {
            v2ForDec.hidden = true
            forInitV2P.hidden = true
            forInitV2IncDec.hidden = true
            v2ForCambio.hidden = true
            forV2IncDec.hidden = true
            v2ForBody.hidden = true
            v2IF.hidden = true
            ifV2IncDec.hidden = true
            endInitV1.text = ";"
            endInitV2.hidden = true
            endPar1.hidden = true
            endPar2.hidden = false
            v2InspectVal.hidden = true
            v2InspectOutput.hidden = true
        }
        else {
            v2ForDec.hidden = false
            forInitV2P.hidden = false
            forInitV2IncDec.hidden = false
            v2ForCambio.hidden = false
            forV2IncDec.hidden = false
            v2ForBody.hidden = false
            v2IF.hidden = false
            ifV2IncDec.hidden = false
            endInitV1.text = ","
            endInitV2.hidden = false
            endPar1.hidden = false
            endPar2.hidden = true
            v2InspectVal.hidden = false
            v2InspectOutput.hidden = false
        }
        
        if !forHeader.actV3 {
            v3start.hidden = true
            v3ForBody.hidden = true
            v3IF.hidden = true
            mainV3.hidden = true
            forV3NumberField.hidden = true
            forV3Mutation.hidden = true
            ifV3NumberField.hidden = true
            ifV3Mutation.hidden = true
            v3InspectVal.hidden = true
            v3InspectOutput.hidden = true
        }
        else {
            v3start.hidden = false
            v3ForBody.hidden = false
            v3IF.hidden = false
            mainV3.hidden = false
            forV3NumberField.hidden = false
            forV3Mutation.hidden = false
            ifV3NumberField.hidden = false
            ifV3Mutation.hidden = false
            v3InspectVal.hidden = false
            v3InspectOutput.hidden = false
        }

    }

    
    
}
