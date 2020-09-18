//
//  LocationModel.swift
//  TinderDemo
//
//  Created by macOS on 9/16/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LocationModel {
    let latitude: String!
    let longitude: String!
    let address: String!
    
    init(json: Dictionary<String, Any>) {
        let jsonParse = JSON(json)
        self.latitude = jsonParse["coordinates"]["latitude"].string ?? "0"
        self.longitude = jsonParse["coordinates"]["longitude"].string ?? "0"
        let number = jsonParse["street"]["number"].int ?? 0
        let street = jsonParse["street"]["name"].string ?? ""
        let city = jsonParse["city"].string ?? ""
        let state = jsonParse["state"].string ?? ""
        let country = jsonParse["country"].string ?? ""
        
        self.address = "\(number) \(street) \(city) \(state) \(country)"
    }
}
