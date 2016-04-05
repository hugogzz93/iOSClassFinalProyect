//
//  ViewControllerOne.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 3/9/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewControllerOne: UIViewController {
    
    var forHeader = ForHeader(
        mainV3: 3,
        forInitV1P: 1,
        forInitV2P: 2,
        
        forInitV1Condition: "<",
        forInitV1NumberField: 10,
        forInitV1IncDec: "++",
        forInitV2IncDec: "--",
        forV1IncDec: "--",
        forV2IncDec: "++",
        forV3Mutation: "-=",
        forV3NumberField: 2,
        coutField1: "v1",
        coutField2: "v2",
        coutField3: "v3",
        ifConditionP1: ">=",
        ifConditionP2: "v2",
        ifV1IncDec: "++",
        ifV2IncDec: "--",
        ifV3Mutation: "+=",
        ifV3NumberField: 2
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindInformation(sender: UIStoryboardSegue){
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "config"{
            let viewConfig: ViewController = segue.destinationViewController as! ViewController
//            viewConfig.ForConfigHeader = forHeader
            
        }
    }
    
    
    
}
