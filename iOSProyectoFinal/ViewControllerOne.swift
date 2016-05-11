//
//  ViewControllerOne.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 3/9/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController, ViewHandler {
    let COLOR_GREEN = 0x2DC289
    let COLOR_RED = 0xDE3746
    
    
    
    var forHeader = ForHeader()
    
    @IBOutlet var viewOneVarTwo: ViewOneVarTwo!
    @IBOutlet var viewFull: ViewFull!
    @IBOutlet var viewOneVar: ViewOneVar!
    @IBOutlet var viewV2V3Mis: ViewV2V3Mis!
    @IBOutlet var viewV2MisIfMis: ViewV2MisIfMis!
    @IBOutlet var viewV3MisIfMis: ViewV3MisIfMis!
    var viewList: Array<View> = []
    
    
    @IBOutlet var viewIfMis: ViewIfMis!
//    viewfull arrows
    @IBOutlet var viewFullArrows: [UIImageView]!
    @IBOutlet var viewOneTwoArrows: [UIImageView]!
    @IBOutlet var viewOneArrows: [UIImageView]!
    @IBOutlet var viewV2V3MisArrows: [UIImageView]!
    @IBOutlet var viewIfMisArrows: [UIImageView]!
    @IBOutlet var viewV2MisIfMisArrows: [UIImageView]!
    @IBOutlet var viewV3MisIfMisArrows: [UIImageView]!
    
    var btnImage = UIImage(named: "play")

    var currentInstruction = 0
    var currentView = 0
    
    //inspector
    @IBOutlet var InsV1Val: UILabel!
    @IBOutlet var InsV2Val: UILabel!
    @IBOutlet var InsV3Val: UILabel!
    
    @IBOutlet var insCout1: UILabel!
    @IBOutlet var insCout2: UILabel!
    @IBOutlet var insCout3: UILabel!
    @IBOutlet var playButton: UIButton!
    
    //qinsCout1: UILabel!
    @IBOutlet var quizLb: UILabel!
    @IBOutlet var quizv1: UITextField!
    @IBOutlet var quizv2: UITextField!
    @IBOutlet var quizv3: UITextField!
    @IBOutlet var quizBck: UIView!
    
    //name labels
    @IBOutlet weak var v1Inspect: UILabel!
    @IBOutlet weak var v2Inspect: UILabel!
    @IBOutlet weak var v3Inspect: UILabel!
    
    @IBOutlet weak var v1Correct: UILabel!
    @IBOutlet weak var v2Correct: UILabel!
    @IBOutlet weak var v3Correct: UILabel!
    
    
//    MARK: - Base
    
    override func viewDidLoad() {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            
            // this code will be executed if the device is an iPad
             func supportedInterfaceOrientations() -> Int {
                return UIInterfaceOrientation.LandscapeLeft.rawValue
            }
            
            func shouldAutorotate() -> Bool {
                return false
            }
            
        }
        
        super.viewDidLoad()
        
        viewFull.setArrowCollection(viewFullArrows)
        viewOneVarTwo.setArrowCollection(viewOneTwoArrows)
        viewOneVar.setArrowCollection(viewOneArrows)
        viewV2V3Mis.setArrowCollection(viewV2V3MisArrows)
        viewIfMis.setArrowCollection(viewIfMisArrows)
        viewV2MisIfMis.setArrowCollection(viewV2MisIfMisArrows)
        viewV3MisIfMis.setArrowCollection(viewV2MisIfMisArrows)
        viewList.append(viewFull)
        viewList.append(viewOneVar)
        viewList.append(viewOneVarTwo)
        viewList.append(viewV2V3Mis)
        viewList.append(viewIfMis)
        viewList.append(viewV2MisIfMis)
        viewList.append(viewV3MisIfMis)
        
        for view in viewList {
            view.delegate = self
        }
        
        selectView(0)
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func unwindEditar(sender: UIStoryboardSegue){

        insCout1.text = "-"
        insCout2.text = "-"
        insCout3.text = "-"
        
        v1Inspect.text = forHeader.nombreV1
        v2Inspect.text = forHeader.nombreV2
        v3Inspect.text = forHeader.nombreV3
        v1Correct.text = forHeader.nombreV1
        v2Correct.text = forHeader.nombreV2
        v3Correct.text = forHeader.nombreV3
        
        selectView(currentView)
        prepareQuiz(currentView)
        updateInspector()
        setQuizStatus(2)
    }
    
    /**
     Hides all views except the selected one, and prepares the selected
     view for execution flow.
     
     - Parameter collection: Collection of arrows being assigned.
     */
    
    func selectView(selectedView : Int) {
        let activeView = viewList[selectedView]
        activeView.setForHeader(forHeader)
        activeView.restart()
        
        for view in viewList {
            view.hidden = true
        }
        
        viewList[selectedView].hidden = false
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "config"{
            let viewConfig: ConfigurationViewController = segue.destinationViewController as! ConfigurationViewController
            viewConfig.ForConfigHeader = forHeader
            
        }
    }
    
    
    // MARK: - Flow Control
    
    /**
     Called by the play button, signals that 
     the next instruciton should be executed.
     
     - Parameter sender: The play button
     */
    @IBAction func play(sender: AnyObject) {
            executeInstruction()
    }
    
    /**
     Signals the active view to execute the instruction and updates 
     inspecrors and if execution is finished, updates de quiz view accordingly.
     
     - Parameter collection: Collection of arrows being assigned.
     */
    func executeInstruction() {
        if !executionFinished() {
            viewList[currentView].executeInstruction()
            updateInspector()
        } else {
            updateQuiz()
        }
        
    }

    /**
     Setter for the current instruction indicator
     
     - Parameter num: the new number of the current instruction
     */
    func setCurrentIns(num : Int) {
        currentInstruction = num
    }
    
    /**
     Updates the labels in the inspector view with the values of their variables.
     */
    func updateInspector() {
        let data = viewList[currentView].getData()
        InsV1Val.text = String(data.v1)
        InsV2Val.text = String(data.v2)
        InsV3Val.text = String(data.v3)
    }
    
    /**
     Checks if the execution has finished or not.
     
     - Return: boolean indicating whether the execution has finished or not
     */
    func executionFinished() -> Bool {
        return viewList[currentView].getExecutionFinished()
    }
    
//    MARK: Quiz View
    
    /**
     Changes the label and background color of the quiz view.
     
     - Parameter type: Different types of status indicating if the quiz is
     answered correctly, incorrectly or neutral.
     */
    func setQuizStatus(type: Int) {
        switch type {
        case 0:
            updateQuizView("Correcto", hexCode: COLOR_GREEN)
        case 1:
            updateQuizView("Incorrecto", hexCode: COLOR_RED)
        case 2:
            updateQuizView("", hexCode: COLOR_GREEN)
        default:break
        }
    }
    
    /**
     Changes the label and background color of the quiz view.
     
     - Parameter string: The new value to be displayed in the label.
     - Parameter hexCode: The new background color to be displayed.
     */
    func updateQuizView(string: String, hexCode: Int) {
        quizLb.text = string
        quizBck.backgroundColor = UIColor(netHex: hexCode)
    }
    
    /**
     Checks whether the quiz is correct or not
     
     - Return: Boolean indicating whether its correct or not.
     */
    func isQuizCorrect() -> Bool {
        let data = viewList[currentView].getData()
        return data.v1 == Float(quizv1.text!)! && data.v2 == Float(quizv2.text!)! && data.v3 == Float(quizv3.text!)!
    }
    
    /**
     Resets the quiz status.
     
     - Parameter num: Different types of settings, depending whether
     there will be a variable eliminated.
     */
    func prepareQuiz(num : Int) {
        quizv1.text = "0"
        quizv2.text = "0"
        quizv3.text = "0"
        
        switch num {
        case 0:
            quizv2.hidden = false
            quizv3.hidden = false
        case 1:
            quizv3.hidden = false
            quizv2.hidden = true
        case 2:
            quizv2.hidden = false
            quizv3.hidden = true
        default:
            break
        }
    }
    
//    MARK: Protocol View Handler
    
    func getCurrentInstruction() -> Int {
        return currentInstruction
    }
    
    func updateCout(output : String, position: Int) {
        switch position {
        case 0: insCout1.text = output
        case 1: insCout2.text = output
        case 2: insCout3.text = output
        default:break
        }
    }
    
    func updateQuiz() {
        setQuizStatus(isQuizCorrect() ? 0 : 1)
    }
    
}



// MARK : Extensions

struct Data {
    var v1 : Float = 0
    var v2 : Float = 0
    var v3 : Float = 0
}

/**
 Hides keyboard when user has clicked outside of the keyboard.
 
 */
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

/**
 Extension used to choose a color with hex values.
 */
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}