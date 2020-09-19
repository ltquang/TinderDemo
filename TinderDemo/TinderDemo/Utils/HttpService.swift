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
                    callBack(nil)
                }
        }
    }
}
