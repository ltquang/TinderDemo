//
//  UIViewExtensions.swift
//  TinderDemo
//
//  Created by macOS on 9/17/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
