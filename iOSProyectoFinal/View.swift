//
//  View.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 4/23/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

/**
  Protocol for the viewController that will
  hold all views that execute the code
 */

protocol ViewHandler {
    /**
     Setter for the current instruction's index.
     */
    func setCurrentIns(num: Int)
    /**
     Getter for the current instruction's index.
     
     - Returns: The current instruction's index.
     */
    func getCurrentInstruction() -> Int
    /**
     Sets the value to be displayed in the inspector labels.
     
     - Parameter output: String to be displayed in the label.
     - Parameter position: Indicator of which label will be dislaying
     the value.
     
     - Return: The number representing the current instruction.
     */
    func updateCout(output : String, position: Int)
    /**
     Verifies if the values entered in the quiz prompts are correct
     and handles the result.
     
     */
    func updateQuiz()
}

/**
 * Protocol for the views being hold by a controller view
 */

protocol ControllerDelegate {
    /**
     Calls the active view to continue instruction flow.
     
     */
    func executeInstruction()
    
    /**
     Getter to verify whether execution has finished.
     
     - Return: Boolean indicating if execution has finished.
     
     */
    func getExecutionFinished() -> Bool
    
    /**
     Getter for the data object storing the three variables.
     
     - Return: The data object.
     */
    func getData() -> Data
    
    /**
     Resets execution flow, flow flags, pointer arrows and data values.
     
     */
    func restart()
    
    /**
     Setter for all the variable values in the view.
     
     - Parameter data: The ForHeader object containing all the values.
     
     */
    func setForHeader(data: ForHeader)
}

enum ViewError: ErrorType {
    case nameNotFound
}


/**
 Parent calss for all views which will be inside a view controller.
 */

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
    
    /**
     Evaluates equality expressions between two floats, greater-than, less-than..etc
     
     - Parameter operatorSign:  The operator for the expression to be evaluated.
     - Parameter leftOperand: left operand of the expression to be evaluated.
     - Parameter rightOperand: right operand of the expression to be evaluated.
     
     - Returns: A boolean whose value is the result of the expression.
     */

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
    
    /**
     Performs an arithemtic operation on a variable, the operation performed depends on
     sign provided.
     
     - Parameter sign: The type of operation to be done on the variable.
     - Parameter numberName: The name of the variable to be mutated.
     
     - Returns:The result of the operation.
     */
    
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

    /**
     Performs an arithemtic operation on two variable, the operation performed depends on
     sign provided.
     
     - Parameter sign: The type of operation to be done.
     - Parameter operands: The names of the two variables that will participate on the operation.
     
     - Returns: The result of the operation.
     */
    
    func expression(sign: String, operands: Array<String>) -> Float {
        let dataResult = getData(operands[1])
        
    	var leftOperand = getData(operands[0])
        let rightOperand =  dataResult != -1 ? dataResult : NSString(string: operands[1]).floatValue

    	switch sign {
	        case "+=":
	            leftOperand += rightOperand
	        case "-=":
	            leftOperand -= rightOperand
            case "*=":
                leftOperand *= rightOperand
            case "/=":
                leftOperand /= rightOperand
	        default: break
        }
        return leftOperand
    }
    
    /**
     Receives a name and fetches its associated value.
     
     - Parameter name: The name whose value is to be obtained.
     
     - Returns: The numeric value associated with that name.
     */

    func getData(name: String) -> Float {
    	var number : Float = -1
        
        if name == forHeader.nombreV1 {
            number = data.v1
        } else if name == forHeader.nombreV2 {
            number = data.v2
        } else if name == forHeader.nombreV3 {
            number = data.v3
        }
        
        return number
    }

    /**
     Assigns a numeric value to the variable corresponding to the provided name.
     
     - Parameter name: The name corresponding to the variable whose value will be updated.
     - Parameter number: The new value to be assigned.
     
     */
    
    func updateData(name: String, number: Float) {
        if name == forHeader.nombreV1 {
            data.v1 = number
        } else if name == forHeader.nombreV2 {
            data.v2 = number
        } else if name == forHeader.nombreV3 {
            data.v3 = number
        }
    }

    /**
     Intermediary in charge of updating stored values with the results obtained by
     arbitrary functions whose parameters also vary.
     
     - Parameter names: Array whose first string is always the name of the variable to be overwritten
     with the operation's result.
     - Parameter sign: Operation's sign to be performed.
     - Parameter instruction: Function to be performed on the provided variable names.
     
     */
    func updateVariable(names: Array<String>, sign: String, instruction: (String, Array<String>) -> Float) {
        updateData(names[0], number: instruction(sign, names))
    }

    //MARK: Concrete Methods
    
    /**
     Fetches the current instruction's number.
     
     - Returns: Number indicating the current instruction being performed.
     */
    func currentInstruction() -> Int {
        return delegate.getCurrentInstruction()
    }
    
    /**
     Handles the necessary processes to be performed once the instruction flow has ended.
     */
    func finalizeExecution() {
        print("Execution finalized")
        executionFinished = true
        setCurrentArrow(-1)
    }
    
    /**
     Manages the coutHandlers to be called depending on the number
     of variables the current view has.
     
     - Returns: The number of the next instruction to be performed.
     */

    func handleCoutIns() -> Int {
        preconditionFailure("This method must be overwritten.")
    }
    
    /**
     Passses instruction to the controllerView delegate with the data
     to be displayed in the inspection view.
     
     - Returns: The number of the next instruction to be performed.
     */

    func coutHandler(name: String, position: Int) {
        
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
    
    /**
     Controls which arrow is visible and which are hidden.
     
     - Parameter num: The index number indicating which arrow
     will be the one visible.
     */
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
    
    /**
     Setter for the list of arrows to be handled by the view.
     
     - Parameter collection: Collection of arrows being assigned.
     */
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

    

