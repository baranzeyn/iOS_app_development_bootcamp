//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Zeynep Baran on 22.08.2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    var result:String?
    var personCount:String?
    var tipPercent:String?
    
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = result
        settingLabel.text="Split between \(personCount ?? "1") people, with \(tipPercent ?? "0.0") tip"
        
        
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
        
    }
}
