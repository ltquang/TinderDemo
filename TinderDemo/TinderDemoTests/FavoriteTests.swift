//
//  FavoriteTests.swift
//  TinderDemoTests
//
//  Created by macOS on 9/19/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import TinderDemo

class FavoriteTests: QuickSpec {
    let favoritefileName = "dataTest.json"
    override func spec() {
        let favoriteManager = FavoriteManager.shared
        describe("get favorite models") {
            beforeEach {
                favoriteManager.setupSaveFileName(file: self.favoritefileName)
                let favorites = favoriteManager.getFavorite()
                favorites.forEach { (fav) in
                    favoriteManager.removeFavorite(user: fav)
                }
            }
            afterEach {
                favoriteManager.setupSaveFileName(file: self.favoritefileName)
                let favorites = favoriteManager.getFavorite()
                favorites.forEach { (fav) in
                    favoriteManager.removeFavorite(user: fav)
                }
            }
            it("get default") {
                let favorites = favoriteManager.getFavorite()
                expect(favorites).to(beEmpty())
            }
            it("append a favorite data") {
                var favorites = favoriteManager.getFavorite()
                expect(favorites).to(beEmpty())
                favoriteManager.appendFavorite(user: self.mockUserModel())
                favorites = favoriteManager.getFavorite()
                expect(favorites.count).to(be(1))
            }
            it("remove a favorite data") {
                var favorites = favoriteManager.getFavorite()
                expect(favorites).to(beEmpty())
                favoriteManager.appendFavorite(user: self.mockUserModel())
                favorites = favoriteManager.getFavorite()
                expect(favorites.count).to(be(1))
                favoriteManager.removeFavorite(user: self.mockUserModel())
                favorites = favoriteManager.getFavorite()
                expect(favorites).to(beEmpty())
            }
        }
    }
    
    func mockUserModel() -> UserModel {
        return UserModel(json: [
            "gender": "female",
            "name": [
                "title": "Mrs",
                "first": "Lea",
                "last": "Ma"
            ],
            "location": [
                "street": [
                    "number": 5188,
                    "name": "Frederick Ave"
                ],
                "city": "Inwood",
                "state": "Québec",
                "country": "Canada",
                "postcode": "V3C 7L2",
                "coordinates": [
                    "latitude": "-65.6236",
                    "longitude": "44.9636"
                ],
                "timezone": [
                    "offset": "+3:00",
                    "description": "Baghdad, Riyadh, Moscow, St. Petersburg"
                ]
            ],
            "email": "lea.ma@example.com",
            "login": [
                "uuid": "a978877d-6393-4a5e-85ca-13d0c14ab057",
                "username": "redbutterfly293",
                "password": "rhino",
                "salt": "oLnNu4Xu",
                "md5": "0383c6d90b482878c232253dbc0b7728",
                "sha1": "e5afe6518e14ea1215e20cbb36056e449dc8a601",
                "sha256": "19ace80bd758d8632dd014feaa54f23ea9ca20ce710f3176da0e912a9781c2ca"
            ],
            "dob": [
                "date": "1990-04-17T11:43:53.681Z",
                "age": 30
            ],
            "registered": [
                "date": "2002-09-30T12:21:54.101Z",
                "age": 18
            ],
            "phone": "026-703-4792",
            "cell": "951-043-3096",
            "id": [
                "name": "",
                "value": nil
            ],
            "picture": [
                "large": "https://randomuser.me/api/portraits/women/75.jpg",
                "medium": "https://randomuser.me/api/portraits/med/women/75.jpg",
                "thumbnail": "https://randomuser.me/api/portraits/thumb/women/75.jpg"
            ],
            "nat": "CA"
        ])
    }
}
