//
//  View.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 4/23/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

protocol ViewHandler {
    func setCurrentIns(num: Int)
    func getCurrentInstruction() -> Int
    func updateCout(output : String, position: Int)
    func updateQuiz()
}

protocol ControllerDelegate {
    func executeInstruction()
    func getExecutionFinished() -> Bool
    func getData() -> Data
    func restart()
    func setForHeader(data: ForHeader)
}

enum ViewError: ErrorType {
    case nameNotFound
}


class View: UIView, ControllerDelegate {
    
    @IBOutlet var pointerCollection: [UIImageView] = []

	var forHeader = ForHeader()
    
    let arraySize = 10
    var forConditional = true
    var ifConditional = true
    var executionFinished = false
    var forInitialized = false
    
    var data = Data()
    var delegate : ViewHandler!


    //MARK: Operation Handlers

    func binaryOperation(operatorSign: String, leftOperand: Float, rightOperand: Float) -> Bool {
    	var result : Bool = false
    	switch operatorSign {
	        case "<":
	            result = leftOperand < rightOperand
	        case "<=":
	            result = leftOperand <= rightOperand
	        case ">":
	            result = leftOperand > rightOperand
	        case ">=":
	            result = leftOperand >= rightOperand
	        case "==":
	            result = leftOperand == rightOperand
	        case "!=":
	            result = leftOperand != rightOperand
	        default: break
	    }

    	return result
    }

    func mutation(sign: String, numberName: Array<String>) -> Float {
    	var number = getData(numberName[0])
        switch sign {
            case "++":
                number += 1
            case "--":
                number -= 1
            case "+=2":
               number += 2
            case "+=3":
                number += 3
            default: break
        }
        return number
    }

    func expression(sign: String, operands: Array<String>) -> Float {
        let dataResult = getData(operands[1])
        
    	var leftOperand = getData(operands[0])
        let rightOperand =  dataResult != -1 ? dataResult : NSString(string: operands[1]).floatValue

    	switch sign {
	        case "+=":
	            leftOperand += rightOperand
	        case "-=":
	            leftOperand -= rightOperand
	        default: break
        }
        return leftOperand
    }

    func getData(name: String) -> Float {
    	var number : Float
    	switch name {
	        case "v1":
	            number = data.v1
	        case "v2":
	            number = data.v2
	        case "v3":
	            number = data.v3
	        default: number = -1
        }
        return number
    }

    func updateData(name: String, number: Float) {
    	switch name {
	        case "v1":
	        	data.v1 = number
	        case "v2":
	        	data.v2 = number
	        case "v3":
	        	data.v3 = number
	        default: break
        }
    }

    func updateVariable(names: Array<String>, sign: String, instruction: (String, Array<String>) -> Float) {
        updateData(names[0], number: instruction(sign, names))
    }

    //MARK: Concrete Methods
    func currentInstruction() -> Int {
        return delegate.getCurrentInstruction()
    }
    
    func finalizeExecution() {
        print("Execution finalized")
        executionFinished = true
        setCurrentArrow(-1)
    }

    func handleCoutIns() -> Int {
        coutHandler("v1", position: 0)
        coutHandler("v2", position: 1)
        coutHandler("v3", position: 2)
        return forStartInstruction()
    }

    func coutHandler(name: String, position: Int) {
        // var outPut = viewList[currentView].getData(name)
        var outPut = getData(name);
        if outPut == -1 {
            outPut = 0.00
        }

        switch position {
            case 0: delegate.updateCout(String(outPut), position: 0)
            case 1: delegate.updateCout(String(outPut), position: 1)
            case 2: delegate.updateCout(String(outPut), position: 2)
            default:break;
        }
    }
    
    func setCurrentArrow(num : Int) {
        
        print("setting current arrow")
        print(num)
        for pointer in getPointerCollection() {
            pointer.hidden = true
        }
        
        if num != -1 {
            getPointerCollection()[num].hidden = false
        }
        
    }
    
    func setArrowCollection(collection: Array<UIImageView>) {
        self.pointerCollection = collection
    }

    //MARK: Protocol ControllerDelegate
    func restart() {
        data.v1 = 0
        data.v2 = 0
        data.v3 = 0
        updateOutlets()
        executionFinished = false
        forInitialized = false
        setCurrentIns(0)
    }
    
    func setCurrentIns(num: Int) {
        if !executionFinished {
            delegate.setCurrentIns(num)
            setCurrentArrow(num)
        }
    }

    func getExecutionFinished() -> Bool {
        return executionFinished
    }

    func getData() -> Data {
        return data
    }
    
    func setForHeader(data: ForHeader) {
        forHeader = data
    }
    
    func getPointerCollection() -> [UIImageView] {
        return pointerCollection
    }

    //MARK: Abstract Methods
    func updateOutlets() {
    	preconditionFailure("This method must be overridden") 
    }

    func executeInstruction() {
    	preconditionFailure("This method must be overridden") 
    }

    func handleInstruction(number: Int) {
    	preconditionFailure("This method must be overridden") 
    }
    
    func forStartInstruction() -> Int {
        preconditionFailure("This method must be overridden")
    }
}

    

