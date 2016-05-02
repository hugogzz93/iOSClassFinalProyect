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
    var viewList: Array<View> = []
    
//    viewfull arrows
    @IBOutlet var viewFullArrows: [UIImageView]!
    @IBOutlet var viewOneTwoArrows: [UIImageView]!
    
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
        viewList.append(viewFull)
        viewList.append(viewOneVar)
        viewList.append(viewOneVarTwo)
        
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
        
        selectView(currentView)
        updateInspector()
        setQuizStatus(2)
        
        
    }
    
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
    
    @IBAction func play(sender: AnyObject) {
            executeInstruction()
    }
    
    func executeInstruction() {
        if !executionFinished() {
            viewList[currentView].executeInstruction()
            updateInspector()
        } else {
            updateQuiz()
        }
        
    }

    func setCurrentIns(num : Int) {
        currentInstruction = num
    }
    
    func updateInspector() {
        let data = viewList[currentView].getData()
        InsV1Val.text = String(data.v1)
        InsV2Val.text = String(data.v2)
        InsV3Val.text = String(data.v3)
    }
    
    func executionFinished() -> Bool {
        return viewList[currentView].getExecutionFinished()
    }
    
//    MARK: Quiz View
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
    
    func updateQuizView(string: String, hexCode: Int) {
        quizLb.text = string
        quizBck.backgroundColor = UIColor(netHex: hexCode)
    }
    
    func isQuizCorrect() -> Bool {
        let data = viewList[currentView].getData()
        return data.v1 == Float(quizv1.text!)! && data.v2 == Float(quizv2.text!)! && data.v3 == Float(quizv3.text!)!
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

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

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