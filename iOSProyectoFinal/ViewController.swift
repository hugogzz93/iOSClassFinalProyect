//
//  ViewController.swift
//  iOSProyectoFinal
//
//  Created by Hugo Gonzalez on 3/7/16.
//  Copyright © 2016 Hugo Gonzalez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let pickerExpressions = ["<", "<=", ">", ">=", "==", "!="]

    @IBOutlet weak var pickerView1: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

