//
//  ViewControllerOne.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 3/9/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

struct Data {
    var v1 : Float = 0
    var v2 : Float = 0
    var v3 : Float = 0
}

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
        ifV3NumberField: "v2"
    )
    
    
    
    var currentInstruction = 0
    let arraySize = 10
    var forConditional = true
    var ifConditional = true
    
    var data = Data()
    
    @IBOutlet var pointerCollection: Array<UIView>?
    //inspector
    @IBOutlet var InsV1Val: UILabel!
    @IBOutlet var InsV2Val: UILabel!
    @IBOutlet var InsV3Val: UILabel!
    @IBOutlet var playButton: UIButton!
    
    var btnImage = UIImage(named: "play")
    
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        playButton.setBackgroundImage(btnImage, forState: UIControlState.Normal)
        updateOutlets()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindEditar(sender: UIStoryboardSegue){
        updateOutlets()
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "config"{
            let viewConfig: ConfigurationViewController = segue.destinationViewController as! ConfigurationViewController
            viewConfig.ForConfigHeader = forHeader
            
        }
    }
    
    func updateOutlets() {
        mainV3.text = String(forHeader.mainV3)
        
        forInitV1P.text = String(forHeader.forInitV1P)
        forInitV2P.text = String(forHeader.forInitV2P)
        
        forInitV1Condition.text = forHeader.forInitV1Condition
        forInitV1NumberField.text = String(forHeader.forInitV1NumberField)
        
        forInitV1IncDec.text = forHeader.forInitV1IncDec
        forInitV2IncDec.text = forHeader.forInitV2IncDec
        
        //for body
        forV1IncDec.text = forHeader.forV1IncDec
        forV2IncDec.text = forHeader.forV2IncDec
        forV3Mutation.text = forHeader.forV3Mutation
        forV3NumberField.text = String(forHeader.forV3NumberField)
        
        coutField1.text = forHeader.coutField1
        coutField2.text = forHeader.coutField2
        coutField3.text = forHeader.coutField3
        
        //if conditional
        ifConditionP1.text = forHeader.ifConditionP1
        ifConditionP2.text = forHeader.ifConditionP2
        
        //if body
        ifV1IncDec.text = forHeader.ifV1IncDec
        ifV2IncDec.text = forHeader.ifV2IncDec
        ifV3Mutation.text = forHeader.ifV3Mutation
        ifV3NumberField.text = forHeader.ifV3NumberField
    }
    
    
    
    // MARK: - Flow Control
    
    @IBAction func play(sender: AnyObject) {
        if currentInstruction <= arraySize {
            executeInstruction()
        }
    }
    
    func executeInstruction() {
        handleInstruction()
        updateInspector()
        setCurrentIns(currentInstruction + 1)
        
    }
    
    func handleInstruction() {
        switch currentInstruction {
        case 1:
            handleForConditional()
        case 2:
            handleConditional()
        case 3:
            handleConditionalInsOne()
        case 4:
            handleConditionalInsTwo()
        case 5:
            handleConditionalInsThree()
        case 6:
            handleLoopInsOne()
        case 7:
            handleLoopInsTwo()
        case 8:
            handleLoopInsThree()
        case 9:
            handleLoopInsCout()
            
        default: break
            
        }
    }
    

    
    func handleForConditional() {
        switch forInitV1Condition {
        case "<":
            forConditional = data.v1 < Float(forHeader.forInitV1NumberField)
        case "<=":
            forConditional = data.v1 <= Float(forHeader.forInitV1NumberField)
        case ">":
            forConditional = data.v1 > Float(forHeader.forInitV1NumberField)
        case ">=":
            forConditional = data.v1 >= Float(forHeader.forInitV1NumberField)
        case "==":
            forConditional = data.v1 == Float(forHeader.forInitV1NumberField)
        case "!=":
            forConditional = data.v1 != Float(forHeader.forInitV1NumberField)
        default: break
            
        }
        
        if forConditional {
            switch forHeader.forInitV1IncDec {
            case "++":
                data.v1 += 1
            case "--":
                data.v1 -= 1
            default: break
            }
            
            switch forHeader.forInitV2IncDec {
            case "++":
                data.v2 += 1
            case "--":
                data.v2 -= 1
            default: break
            }
        }
    }
    
    func handleConditional() {
        
        var number : Float = 0
        
        switch forHeader.ifConditionP2 {
        case "v1":
            number = data.v1
        case "v2":
            number = data.v2
        case "v3":
            number = data.v3
        default: break
        }
        
        switch forHeader.ifConditionP1 {
        case "<":
            ifConditional = data.v1 < number
        case "<=":
            ifConditional = data.v1 <= number
        case ">":
            ifConditional = data.v1 > number
        case ">=":
            ifConditional = data.v1 >= number
        case "==":
            ifConditional = data.v1 == number
        case "!=":
            ifConditional = data.v1 != number
        default: break
        }

    }
    
    func handleConditionalInsOne() {
        
        switch forHeader.ifV1IncDec {
        case "++":
            data.v1 += 1
        case "--":
            data.v1 -= 1
        default: break
        }
        
    }
    
    func handleConditionalInsTwo() {
        switch forHeader.ifV2IncDec {
        case "++":
            data.v2 += 1
        case "--":
            data.v2 -= 1
        default: break
        }
    }
    
    func handleConditionalInsThree() {
        var number : Float = 0
        switch forHeader.ifV3NumberField {
        case "v1":
            number = data.v1
        case "v2":
            number = data.v2
        case "v3":
            number = data.v3
        default: break;
        }
        
        switch forHeader.ifV3Mutation {
        case "+=":
            data.v3 += number
        case "-=":
            data.v3 -= number
        default: break
        }
        
    }
    
    func handleLoopInsOne() {
        switch forHeader.forV1IncDec {
        case "++":
            data.v1 += 1
        case "--":
            data.v1 -= 1
        default: break
        }
        
    }
    
    func handleLoopInsTwo() {
        switch forHeader.forV2IncDec {
        case "++":
            data.v2 += 1
        case "--":
            data.v2 -= 1
        default: break
        }
        
    }
    
    func handleLoopInsThree() {
        
        switch forHeader.forV3Mutation {
        case "+=":
            data.v3 += Float(forHeader.forV3NumberField)
        case "-=":
            data.v3 -= Float(forHeader.forV3NumberField)
        default: break
        }
        
    }
    
    func handleLoopInsCout() {
        
        setCurrentIns(1)
        
    }
    
    func updateInspector() {
        
        InsV1Val.text = String(data.v1)
        InsV2Val.text = String(data.v2)
        InsV3Val.text = String(data.v3)
    }
    
    func setCurrentIns(num: Int) {
        currentInstruction = num
        
        for pointer in pointerCollection! {
            pointer.hidden = true
        }
        pointerCollection![num].hidden = false
    }

    
    
}
