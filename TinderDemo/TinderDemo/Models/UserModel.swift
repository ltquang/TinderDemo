//
//  UserModel.swift
//  TinderDemo
//
//  Created by macOS on 9/16/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import SwiftyJSON

struct UserModel: Equatable {
    
    let uuid: String!
    let name : String!
    let email : String!
    let dob: String!
    let phone: String!
    let cell: String!
    let picture: String!
    let location: LocationModel!
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    init(json: Dictionary<String, Any>) {
        let jsonParse = JSON(json)
        self.uuid = jsonParse["login"]["uuid"].string ?? ""
        let title = jsonParse["name"]["title"].string ?? ""
        let firstName = jsonParse["name"]["first"].string ?? ""
        let lastName = jsonParse["name"]["last"].string ?? ""
        self.name = "\(title) \(firstName) \(lastName)"
        self.email = jsonParse["email"].string ?? "No email"
        self.dob = jsonParse["dob"]["date"].string ?? "1970-01-01T00:00:00.000Z"
        self.phone = jsonParse["phone"].string ?? "0"
        self.cell = jsonParse["cell"].string ?? "0"
        self.picture = jsonParse["picture"]["large"].string ?? ""
        self.location = LocationModel.init(json: json["location"] as! Dictionary<String, Any>)
    }
}
