//
//  ViewV3MisIfMis.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 5/10/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewV3MisIfMis: View {
    
    let FOR_START = 0
    
    
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
    
    //labels
    @IBOutlet weak var v1ForDec: UILabel!
    @IBOutlet weak var v2ForDec: UILabel!
    @IBOutlet weak var v1ForCompare: UILabel!
    @IBOutlet weak var v1ForCambio: UILabel!
    @IBOutlet weak var v2ForCambio: UILabel!
    
    @IBOutlet weak var v1ForBody: UILabel!
    @IBOutlet weak var v2ForBody: UILabel!
    
    
    
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
        
        v1ForDec.text = "for ( int "+forHeader.nombreV1+" ="
        v2ForDec.text = ", " + forHeader.nombreV2 + " ="
        v1ForCompare.text = "; "+forHeader.nombreV1
        v1ForCambio.text = "; "+forHeader.nombreV1
        v2ForCambio.text = ", "+forHeader.nombreV2
        v1ForBody.text = forHeader.nombreV1
        v2ForBody.text = forHeader.nombreV2
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
            }
            nextInstruction = handleForConditional()
        case 1:
            nextInstruction = handleLoopIns(1)
        case 2:
            nextInstruction = handleLoopIns(2)
        case 3:
            nextInstruction = handleCoutIns()
            data.v1 = mutation(forHeader.forInitV1IncDec, numberName: [forHeader.nombreV1])
            data.v2 = mutation(forHeader.forInitV2IncDec, numberName: [forHeader.nombreV2])
            
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
    /**
     Checks whether the for conditional is true or not and handles the outcome.
     
     - Return: Number indicating which is the next instruction to be executed.
     */
    func handleForConditional() -> Int {
        
        forConditional = binaryOperation(forHeader.forInitV1Condition, leftOperand: data.v1, rightOperand: Float(forHeader.forInitV1NumberField))
        
        if !forConditional {
            finalizeExecution()
        }
        
        return currentInstruction() + 1
    }
    
    /**
     Handles the instructions inside the if.
     
     - Parameter Ins: Number indicating which instruction inside the if is being executed.
     - Return: Number indicating which is the next instruction to be executed.
     */
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
    
    /**
     Handles the instructions inside the loop.
     
     - Parameter Ins: Number indicating which instruction inside the if is being executed.
     - Return: Number indicating which is the next instruction to be executed.
     */
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



