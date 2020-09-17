//
//  UserViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/17/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        imageView.imageFromUrl(urlString: "https://randomuser.me/api/portraits/men/19.jpg")
    }
}




