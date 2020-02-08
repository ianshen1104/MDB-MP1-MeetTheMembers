//
//  StatisticsScreenVC.swift
//  MatchTheMembers
//
//  Created by Ian Shen on 2/5/20.
//  Copyright © 2020 Ian Shen. All rights reserved.
//

import UIKit

class StatisticsScreenVC: UIViewController {
    
    @IBOutlet weak var streakNumberLabel: UILabel!
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var name3Label: UILabel!
    @IBOutlet weak var correct1Label: UILabel!
    @IBOutlet weak var correct2Label: UILabel!
    @IBOutlet weak var correct3Label: UILabel!
    
    var streak: Int = 0
    var nameHis: [String] = []
    var ansHis: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streakNumberLabel.text = String(streak)
        name1Label.text = "1. \(nameHis[0])"
        name2Label.text = "2. \(nameHis[1])"
        name3Label.text = "3. \(nameHis[2])"
        correct1Label.text = ansHis[0]
        correct2Label.text = ansHis[1]
        correct3Label.text = ansHis[2]
    }
    
    @IBAction func returnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
