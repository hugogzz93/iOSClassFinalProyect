//
//  ViewOneVarTwo.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 5/1/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewOneVarTwo: View {
    
    let FOR_START = 0
    let AFTER_IF = 4
    let IF_START = 2
    
    
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
    
    @IBOutlet weak var coutField1: UITextField!
    @IBOutlet weak var coutField2: UITextField!
    
    //if conditional
    @IBOutlet weak var ifConditionP1: UITextField!
    @IBOutlet weak var ifConditionP2: UITextField!
    
    //if body
    @IBOutlet weak var ifV1IncDec: UITextField!
    @IBOutlet weak var ifV2IncDec: UITextField!
    
    //labels
    @IBOutlet weak var v1ForDec: UILabel!
    @IBOutlet weak var v2ForDec: UILabel!
    @IBOutlet weak var v1ForCompare: UILabel!
    @IBOutlet weak var v1ForCambio: UILabel!
    @IBOutlet weak var v2ForCambio: UILabel!
    
    @IBOutlet weak var v1ForBody: UILabel!
    @IBOutlet weak var v2ForBody: UILabel!
    
    @IBOutlet weak var ifV1Compare: UILabel!
    @IBOutlet weak var v1IF: UILabel!
    @IBOutlet weak var v2IF: UILabel!

    
    
    // MARK: Protocol
    
    override func updateOutlets() {
        
        forInitV1P.text = String(forHeader.forInitV1P)
        forInitV2P.text = String(forHeader.forInitV2P)
        
        forInitV1Condition.text = forHeader.forInitV1Condition
        forInitV1NumberField.text = String(forHeader.forInitV1NumberField)
        
        forInitV1IncDec.text = forHeader.forInitV1IncDec
        forInitV2IncDec.text = forHeader.forInitV2IncDec
        
        //for body
        forV1IncDec.text = forHeader.forV1IncDec
        
        coutField1.text = forHeader.coutField1
        coutField2.text = forHeader.coutField2
        
        //if conditional
        ifConditionP1.text = forHeader.ifConditionP1
        ifConditionP2.text = forHeader.ifConditionP2
        
        //if body
        ifV1IncDec.text = forHeader.ifV1IncDec
        ifV2IncDec.text = forHeader.ifV2IncDec
        
        v1ForDec.text = "for ( int "+forHeader.nombreV1+"="
        v2ForDec.text = forHeader.nombreV2+"="
        v1ForCompare.text = ";"+forHeader.nombreV1
        v1ForCambio.text = ";"+forHeader.nombreV1
        v2ForCambio.text = ", "+forHeader.nombreV2
        v1ForBody.text = forHeader.nombreV1
        v2ForBody.text = forHeader.nombreV2
        ifV1Compare.text = "if ("+forHeader.nombreV1
        v1IF.text = forHeader.nombreV1
        v2IF.text = forHeader.nombreV2
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
            if !forInitialized {
                data.v1 = Float(forHeader.forInitV1P)
                data.v2 = Float(forHeader.forInitV2P)
                forInitialized = true
                nextInstruction = currentInstruction() + 1
            } else {
                nextInstruction = handleForConditional()
            }
            
        case 1:
            nextInstruction = handleConditional()
        case 2:
            nextInstruction = handleIfIns(1)
        case 3:
            nextInstruction = handleIfIns(2)
        case 4:
            nextInstruction = handleLoopIns(1)
        case 5:
            nextInstruction = handleLoopIns(2)
        case 6:
            nextInstruction = handleCoutIns()
            
        default: break
            
        }
        
        setCurrentIns(nextInstruction)
    }
    
    override func forStartInstruction() -> Int {
        return FOR_START
    }
    
    override func handleCoutIns() -> Int {
        coutHandler(forHeader.coutField1, position: 0)
        coutHandler(forHeader.coutField2, position: 1)
        return forStartInstruction()
    }
    
    
    //MARK: Handlers
    
    func handleForConditional() -> Int {
        
        forConditional = binaryOperation(forHeader.forInitV1Condition, leftOperand: data.v1, rightOperand: Float(forHeader.forInitV1NumberField))
        
        if forConditional {
            data.v1 = mutation(forHeader.forInitV1IncDec, numberName: [forHeader.nombreV1])
            data.v2 = mutation(forHeader.forInitV2IncDec, numberName: [forHeader.nombreV2])
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
            varNames = [forHeader.nombreV1]
            sign = forHeader.ifV1IncDec
            instruction = mutation
        case 2:
            varNames = [forHeader.nombreV2]
            sign = forHeader.ifV2IncDec
            instruction = mutation
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
            varNames = [forHeader.nombreV1]
            sign = forHeader.forV1IncDec
            instruction = mutation
        case 2:
            varNames = [forHeader.nombreV2]
            sign = forHeader.forV2IncDec
            instruction = mutation
        default:break
        }
        
        updateVariable(varNames, sign: sign, instruction: instruction)
        return currentInstruction() + 1
    }
    
}

