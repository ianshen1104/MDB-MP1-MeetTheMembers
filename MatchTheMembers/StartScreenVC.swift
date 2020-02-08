//
//  ViewController.swift
//  MatchTheMembers
//
//  Created by Ian Shen on 2/5/20.
//  Copyright © 2020 Ian Shen. All rights reserved.
//

import UIKit

class StartScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toMainScreenVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MainScreenVC {
            destinationVC.inPlay = true
        }
    }
    
}

