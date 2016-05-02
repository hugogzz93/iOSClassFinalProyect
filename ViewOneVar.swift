//
//  ViewOneVar.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 5/1/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewOneVar: View {
    
    let AFTER_IF = 5
    let IF_START = 3
    
    @IBOutlet var pointerCollection: Array<UIView>?
    
    @IBOutlet weak var mainV3: UITextField!
    
    //for init
    @IBOutlet weak var forInitV1P: UITextField!
    
    @IBOutlet weak var forInitV1Condition: UITextField!
    @IBOutlet weak var forInitV1NumberField: UITextField!
    
    @IBOutlet weak var forInitV1IncDec: UITextField!
    
    //for body
    @IBOutlet weak var forV1IncDec: UITextField!
    @IBOutlet weak var forV3Mutation: UITextField!
    @IBOutlet weak var forV3NumberField: UITextField!
    
    @IBOutlet weak var coutField1: UITextField!
    @IBOutlet weak var coutField2: UITextField!
    
    //if conditional
    @IBOutlet weak var ifConditionP1: UITextField!
    @IBOutlet weak var ifConditionP2: UITextField!
    
    //if body
    @IBOutlet weak var ifV1IncDec: UITextField!
    @IBOutlet weak var ifV3Mutation: UITextField!
    @IBOutlet weak var ifV3NumberField: UITextField!
    
    
    // MARK: Protocol
    
    override func updateOutlets() {
        mainV3.text = String(forHeader.mainV3)
        
        forInitV1P.text = String(forHeader.forInitV1P)
        
        forInitV1Condition.text = forHeader.forInitV1Condition
        forInitV1NumberField.text = String(forHeader.forInitV1NumberField)
        
        forInitV1IncDec.text = forHeader.forInitV1IncDec
        
        //for body
        forV1IncDec.text = forHeader.forV1IncDec
        forV3Mutation.text = forHeader.forV3Mutation
        forV3NumberField.text = String(forHeader.forV3NumberField)
        
        coutField1.text = forHeader.coutField1
        coutField2.text = forHeader.coutField2
        
        //if conditional
        ifConditionP1.text = forHeader.ifConditionP1
        ifConditionP2.text = forHeader.ifConditionP2
        
        //if body
        ifV1IncDec.text = forHeader.ifV1IncDec
        ifV3Mutation.text = forHeader.ifV3Mutation
        ifV3NumberField.text = forHeader.ifV3NumberField
    }
    
    override func executeInstruction() {
        if !executionFinished {
            handleInstruction(currentInstruction())
        }
    }
    
    override func handleInstruction(number: Int) {
        var nextInstruction = 0
        switch number {
        case 0:
            data.v3 = Float(forHeader.mainV3)
            nextInstruction = currentInstruction() + 1
        case 1:
            if !forInitialized {
                data.v1 = Float(forHeader.forInitV1P)
                forInitialized = true
                nextInstruction = currentInstruction() + 1
            } else {
                nextInstruction = handleForConditional()
            }
            
        case 2:
            nextInstruction = handleConditional()
        case 3:
            nextInstruction = handleIfIns(1)
        case 4:
            nextInstruction = handleIfIns(3)
        case 5:
            nextInstruction = handleLoopIns(1)
        case 6:
            nextInstruction = handleLoopIns(3)
        case 7:
            nextInstruction = handleCoutIns()
            
        default: break
            
        }
        
        setCurrentIns(nextInstruction)
    }
    
    override func getPointerCollection() -> Array<UIView> {
        return pointerCollection!
    }
    
    //MARK: Handlers
    
    func handleForConditional() -> Int {
        
        forConditional = binaryOperation(forHeader.forInitV1Condition, leftOperand: data.v1, rightOperand: Float(forHeader.forInitV1NumberField))
        
        if forConditional {
            data.v1 = mutation(forHeader.forInitV1IncDec, numberName: ["v1"])
        } else {
            finalizeExecution()
        }
        
        return currentInstruction() + 1
    }
    
    func handleConditional() -> Int {
        var number : Float = 0
        var nextIns = 0
        number = getData(forHeader.ifConditionP2)
        ifConditional = binaryOperation(forHeader.ifConditionP1, leftOperand: data.v1, rightOperand: number)
        
        if !ifConditional {
            nextIns = AFTER_IF
        } else {
            nextIns = IF_START
        }
        return nextIns
    }
    
    func handleIfIns(Ins: Int) -> Int {
        var varNames = Array<String>(), sign = ""
        var instruction: (String, Array<String>) -> Float = mutation
        switch Ins {
        case 1:
            varNames = ["v1"]
            sign = forHeader.ifV1IncDec
            instruction = mutation
        case 3:
            varNames = ["v3", forHeader.ifV3NumberField]
            sign = forHeader.ifV3Mutation
            instruction = expression
        default:break
        }
        
        updateVariable(varNames, sign: sign, instruction: instruction)
        return currentInstruction() + 1
    }
    
    func handleLoopIns(Ins: Int) -> Int {
        var varNames = Array<String>(), sign = ""
        var instruction: (String, Array<String>) -> Float = mutation
        switch Ins {
        case 1:
            varNames = ["v1"]
            sign = forHeader.forV1IncDec
            instruction = mutation
        case 3:
            varNames = ["v3", String(forHeader.forV3NumberField)]
            sign = forHeader.forV3Mutation
            instruction = expression
        default:break
        }
        
        updateVariable(varNames, sign: sign, instruction: instruction)
        return currentInstruction() + 1
    }
    
}
