//
//  FavoriteManager.swift
//  TinderDemo
//
//  Created by macOS on 9/18/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation

class FavoriteManager {
    static let shared = FavoriteManager()
    private init(){}
    
    private var favorites: [UserModel] = []
    func getFavorite() -> [UserModel] {
        return favorites
    }
    
    func appendFavorite(user: UserModel) {
        if !favorites.contains(user) {
            favorites.append(user)
        }
    }
    
    func removeFavorite(user: UserModel) {
        if let index = favorites.firstIndex(of: user) {
            favorites.remove(at: index)
        }
    }
}
