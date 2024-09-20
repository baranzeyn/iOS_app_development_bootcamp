//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Zeynep Baran on 21.08.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var background: UIView!
    var bmiValue:String?
    var advice:String?
    var backgroundColor:UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text=bmiValue
        adviceLabel.text=advice
        background.backgroundColor=backgroundColor
    }
    

    @IBAction func recalculate(_ sender: UIButton) {//önceki sayfaya dön
        self.dismiss(animated: true,completion: nil)
    }
    

}
