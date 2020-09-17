//
//  UserViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/17/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit

class UserViewController: DetailBaseController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        imageView.imageFromUrl(urlString: userModel.picture)
    }
}




