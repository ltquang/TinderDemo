//
//  CardViewController.swift
//  TinderDemo
//
//  Created by macOS on 9/16/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit

class CardViewController: UITabBarController {
    var userModel: UserModel!
    override func viewDidLoad() {
        viewControllers!.forEach {
            if $0.isKind(of: DetailBaseController.self) {
                ($0 as! DetailBaseController).userModel = userModel
            }
        }
    }
}
