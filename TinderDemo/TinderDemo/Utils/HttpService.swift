//
//  HTTPSevice.swift
//  TinderDemo
//
//  Created by macOS on 9/18/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import Alamofire

protocol HttpServiceProtocol {
    func getUser(callBack:@escaping ([String: Any]?) -> Void)
}

class HttpService: HttpServiceProtocol {
    let baseURL = "https://randomuser.me/api/?results=50"
    
    func getUser(callBack: @escaping ([String : Any]?) -> Void) {
        AF.request(baseURL)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    callBack(response.value as? [String : Any])
                case let .failure(error):
                    print(error.localizedDescription)
                }
        }
    }
}

class HttpServiceMockSuccess: HttpServiceProtocol {
    func getUser(callBack: @escaping ([String : Any]?) -> Void) {
        let result = [
            "results": [
                [
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
                ]]
        ]
        callBack(result)
    }
}

class HttpServiceMockFail: HttpServiceProtocol {
    func getUser(callBack: @escaping ([String : Any]?) -> Void) {
        callBack(nil)
    }
}
