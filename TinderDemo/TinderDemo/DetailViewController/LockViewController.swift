//
//  LockViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/18/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit

class LockViewController: DetailBaseController {
    
    @IBOutlet weak var cellPhoneButton: UIButton!
    
    override func viewDidLoad() {
        cellPhoneButton.setTitle(userModel.cell, for: .normal)
    }
    @IBAction func touchCalling(_ sender: Any) {
        if let number = userModel.cell,
            let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url)
        }
    }
}
