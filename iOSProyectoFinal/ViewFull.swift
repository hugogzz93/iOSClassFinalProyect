//
//  ViewFull.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 4/23/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewFull: View {

	let AFTER_IF = 5
	let IF_START = 2
    
    @IBOutlet var pointerCollection: Array<UIView>?
    
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
    
    //quiz fields
    @IBOutlet var quizLb: UILabel!
    @IBOutlet var quizv1: UITextField!
    @IBOutlet var quizv2: UITextField!
    @IBOutlet var quizv3: UITextField!
    @IBOutlet var quizBck: UIView!

	// MARK: Protocol

	override func updateOutlets() {
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

    override func executeInstruction() {
        if !executionFinished {
                handleInstruction()
                setCurrentIns(currentInstruction() + 1)
        }   
    }

    func handleInstruction(number: Int) {
        switch number {
        case 0:
            data.v3 = Float(forHeader.mainV3)
        case 1:
            if !forInitialized {
                data.v1 = Float(forHeader.forInitV1P)
                data.v2 = Float(forHeader.forInitV2P)
                forInitialized = true
            } else {
                handleForConditional()
            }
            
        case 2:
            handleConditional()
        case 3:
            handleIfIns(1)
        case 4:
            handleIfIns(2)
        case 5:
            handleIfIns(3)
        case 6:
            handleLoopIns(1)
        case 7:
            handleLoopIns(2)
        case 8:
            handleLoopIns(3)
        case 9:
            handleCoutIns()
            
        default: break
            
        }
    }

    //MARK: Handlers

    func handleForConditional() {
        
        forConditional = binaryOperation(forHeader.forInitV1Condition, leftOperand: data.v1, rightOperand: Float(forHeader.forInitV1NumberField))
        
        if forConditional {
            var name = [String(data.v1)], name2 = [String(data.v2)]
        	data.v1 = mutation(forHeader.forInitV1IncDec, numberName: name)
        	data.v2 = mutation(forHeader.forInitV2IncDec, numberName: name2)
        } else {
            finalizeExecution()
        }
    }

    func handleConditional() {
        var number : Float = 0
        number = getData(forHeader.ifConditionP2)
        ifConditional = binaryOperation(forHeader.ifConditionP1, leftOperand: data.v1, rightOperand: number)
        
        if !ifConditional {
            setCurrentIns(AFTER_IF)
        } else {
            setCurrentIns(IF_START)
        }
    }

    func handleIfIns(Ins: Int) {
    	var varNames = Array<String>(), sign = ""
    	var instruction = (String, Array<String>) -> Float
    	switch Ins {
	    	case 1: 
	    		varNames = ["v1"]
	    		sign = forHeader.ifV1IncDec
	    		instruction = mutation
	    	case 2: 
	    		varNames = ["v2"]
	    		sign = forHeader.ifV2IncDec
	    		instruction = mutation
	    	case 3: 
	    		varNames = ["v3", forHeader.ifV3NumberField]
	    		sign = forHeader.ifV3Mutation
	    		instruction = expression
	    	default:break
    	}

    	updateVariable(varNames, sign, instruction)
    }

    func handleLoopIns(Ins: Int) {
    	var varNames = Array<String>(), sign = ""
    	var instruction = () -> ()
    	switch Ins {
	    	case 1: 
	    		varNames = ["v1"]
	    		sign = forHeader.forV1IncDec
	    		instruction = mutation()
	    	case 2: 
	    		varNames = ["v2"]
	    		sign = forHeader.forV2IncDec
	    		instruction = mutation()
	    	case 3: 
	    		varNames = ["v3", forHeader.forV3NumberField]
	    		sign = forHeader.forV3Mutation
	    		instruction = expression()
	    	default:break
    	}

    	updateVariable(varNames, sign, instruction)
    }

    // MARK: Flow Control
    func setCurrentIns(num: Int) {
        if !executionFinished {
            delegate.setCurrentIns(num)
            
            for pointer in pointerCollection! {
                pointer.hidden = true
            }
            pointerCollection![num].hidden = false
        }
    }

// forHeader.ifV1IncDec

    // func updateVariable(name: String, sign: String, instruction: (String, Int) -> Int) {
    //     updateData(name, instruction(sign, getData(name)))
    // }



}
