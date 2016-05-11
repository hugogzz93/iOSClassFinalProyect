//
//  ViewV2MisIfMis.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 5/10/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewV2MisIfMis: View {
        
        let FOR_START = 1
        
        
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
    
        
        //text labels
        @IBOutlet weak var v3start: UILabel!
        
        @IBOutlet weak var v1ForDec: UILabel!
        @IBOutlet weak var v1ForCompare: UILabel!
        @IBOutlet weak var v1ForCambio: UILabel!
        
        @IBOutlet weak var v1ForBody: UILabel!
        @IBOutlet weak var v3ForBody: UILabel!
        
        
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

            
            v3start.text = "int "+forHeader.nombreV3+" ="
            v1ForDec.text = "for ( int "+forHeader.nombreV1+" ="
            v1ForCompare.text = "; "+forHeader.nombreV1
            v1ForCambio.text = "; "+forHeader.nombreV1
            v1ForBody.text = forHeader.nombreV1
            v3ForBody.text = forHeader.nombreV3
            
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
                }
                nextInstruction = handleForConditional()
            case 2:
                nextInstruction = handleLoopIns(1)
            case 3:
                nextInstruction = handleLoopIns(3)
            case 4:
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
            case 3:
                varNames = [forHeader.nombreV3, forHeader.ifV3NumberField]
                sign = forHeader.ifV3Mutation
                instruction = expression
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
            case 3:
                varNames = [forHeader.nombreV3, String(forHeader.forV3NumberField)]
                sign = forHeader.forV3Mutation
                instruction = expression
            default:break
            }
            
            updateVariable(varNames, sign: sign, instruction: instruction)
            return currentInstruction() + 1
        }
        
}

