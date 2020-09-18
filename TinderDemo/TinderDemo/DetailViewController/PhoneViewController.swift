//
//  PhoneViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/18/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit

class PhoneViewController: DetailBaseController {
    @IBOutlet weak var phoneButton: UIButton!
    
    override func viewDidLoad() {
        phoneButton.setTitle(userModel.phone, for: .normal)
    }
    
    @IBAction func touchCalling(_ sender: Any) {
        if let number = userModel.phone,
            let url = URL(string: "tel://\(number)") {
            UIApplication.shared.open(url)
        }
    }
}
