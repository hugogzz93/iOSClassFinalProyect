//
//  File.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 5/10/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

//
//  ViewOneVarTwo.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 5/1/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewV2V3Mis: View {
    
    let FOR_START = 0
    
    
    //for init
    @IBOutlet weak var forInitV1P: UITextField!
    
    @IBOutlet weak var forInitV1Condition: UITextField!
    @IBOutlet weak var forInitV1NumberField: UITextField!
    
    @IBOutlet weak var forInitV1IncDec: UITextField!
    
    //for body
    @IBOutlet weak var forV1IncDec: UITextField!
    
    @IBOutlet weak var coutField1: UITextField!
    
    //labels
    @IBOutlet weak var v1ForDec: UILabel!
    @IBOutlet weak var v1ForCompare: UILabel!
    @IBOutlet weak var v1ForCambio: UILabel!
    
    @IBOutlet weak var v1ForBody: UILabel!
    
    // MARK: Protocol
    
    override func updateOutlets() {
        
        forInitV1P.text = String(forHeader.forInitV1P)
        
        forInitV1Condition.text = forHeader.forInitV1Condition
        forInitV1NumberField.text = String(forHeader.forInitV1NumberField)
        
        forInitV1IncDec.text = forHeader.forInitV1IncDec
        
        //for body
        forV1IncDec.text = forHeader.forV1IncDec
        
        coutField1.text = forHeader.coutField1

        v1ForDec.text = "for ( int "+forHeader.nombreV1+" ="
        v1ForCompare.text = "; "+forHeader.nombreV1
        v1ForCambio.text = "; "+forHeader.nombreV1
        v1ForBody.text = forHeader.nombreV1
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
            nextInstruction = handleCoutIns()
            data.v1 = mutation(forHeader.forInitV1IncDec, numberName: [forHeader.nombreV1])
        default: break
        }
        
        setCurrentIns(nextInstruction)
    }
    
    override func forStartInstruction() -> Int {
        return FOR_START
    }
    
    override func handleCoutIns() -> Int {
        coutHandler(forHeader.coutField1, position: 0)
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
        default:break
        }
        
        updateVariable(varNames, sign: sign, instruction: instruction)
        return currentInstruction() + 1
    }
    
}


