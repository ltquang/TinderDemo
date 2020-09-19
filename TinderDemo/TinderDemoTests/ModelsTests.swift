//
//  UserModelsTests.swift
//  TinderDemoTests
//
//  Created by macOS on 9/19/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import TinderDemo

class ModelsTests: QuickSpec {
    override func spec() {
        describe("init models") {
            it("success") {
                let userModel = UserModel(json: self.mockUserData())
                expect(userModel).notTo(beNil())
            }
            it("fail missing uuid") {
                var mockData = self.mockUserData()
                mockData["login"] = nil
                let userModel = UserModel(json: mockData)
                expect(userModel.uuid).to(be(""))
            }
            it("fail missing name") {
                var mockData = self.mockUserData()
                mockData["name"] = ""
                let userModel = UserModel(json: mockData)
                expect(userModel.name).to(match("  "))
            }
            it("fail missing email") {
                var mockData = self.mockUserData()
                mockData["email"] = nil
                let userModel = UserModel(json: mockData)
                expect(userModel.email).to(match("No email"))
            }
            it("fail missing dob") {
                var mockData = self.mockUserData()
                mockData["dob"] = nil
                let userModel = UserModel(json: mockData)
                expect(userModel.dob).to(match("1970-01-01T00:00:00.000Z"))
            }
            it("fail missing phone") {
                var mockData = self.mockUserData()
                mockData["phone"] = nil
                let userModel = UserModel(json: mockData)
                expect(userModel.phone).to(be("0"))
            }
            it("fail missing cell") {
                var mockData = self.mockUserData()
                mockData["cell"] = nil
                let userModel = UserModel(json: mockData)
                expect(userModel.cell).to(match("0"))
            }
            it("fail missing picture") {
                var mockData = self.mockUserData()
                mockData["picture"] = ""
                let userModel = UserModel(json: mockData)
                expect(userModel.picture).to(be(""))
            }
            it("fail missing location") {
                var mockData = self.mockUserData()
                mockData["location"] = nil
                let userModel = UserModel(json: mockData)
                expect(userModel.location.latitude).to(be("0"))
                expect(userModel.location.longitude).to(be("0"))
                expect(userModel.location.address).to(match("    "))
            }
        }
    }
    
    func mockUserData() -> [String: Any] {
        return [
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
        ]
    }
}
