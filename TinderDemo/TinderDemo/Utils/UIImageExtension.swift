//
//  UIImageExtension.swift
//  TinderDemo
//
//  Created by macOS on 9/17/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        AF.request(urlString).response { (response) in
            if let data = response.data {
                self.image = UIImage(data: data)
            }
        }
    }
}
