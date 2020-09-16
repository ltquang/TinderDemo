//
//  UserModel.swift
//  TinderDemo
//
//  Created by macOS on 9/16/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation

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
}
