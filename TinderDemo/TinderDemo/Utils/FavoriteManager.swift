//
//  FavoriteManager.swift
//  TinderDemo
//
//  Created by macOS on 9/18/20.
//  Copyright © 2020 macOS. All rights reserved.
//

import Foundation
import SwiftyJSON

enum FavoriteError: Error {
    case runtimeError(String)
}

class FavoriteManager {
    static let shared = FavoriteManager()
    private init(){}
    
    private var favorites: [UserModel]? = nil
    func getFavorite() -> [UserModel] {
        if favorites == nil {
            readJSON()
        }
        return favorites!
    }
    
    func appendFavorite(user: UserModel) {
        if favorites == nil {
            favorites = []
        }
        if !favorites!.contains(user) {
            favorites!.append(user)
            try? writeToFile()
        }
    }
    
    func removeFavorite(user: UserModel) {
        if favorites == nil {
            return
        }
        if let index = favorites!.firstIndex(of: user) {
            favorites!.remove(at: index)
            try? writeToFile()
        }
    }
    
    private func readJSON() {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!

        guard let url = documentsDirectoryPath.appendingPathComponent("data.json")  else {
            return
        }
        if let dataArray = NSArray(contentsOf: URL(string: "file://\(url.absoluteString)")!) as? [Data] {
            favorites = []
            dataArray.forEach { (rawdata) in
                let decoder = JSONDecoder()
                if let data = try? decoder.decode(UserModel.self, from: rawdata) {
                    favorites?.append(data)
                }
            }
        }
        
    }

    private func writeToFile() throws {
        let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!

        guard let url = documentsDirectoryPath.appendingPathComponent("data.json") else {
            throw FavoriteError.runtimeError("File not found!")
        }
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: url.absoluteString, isDirectory: nil) {
            let created = fileManager.createFile(atPath: url.absoluteString, contents: nil, attributes: nil)
            if !created {
                throw FavoriteError.runtimeError("Couldn't create file!")
            }
        }
        var dataList:[Any] = []
        favorites?.forEach({ (fav) in
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(fav) {
                dataList.append(data)
            }
        })
        do {
            try (dataList as NSArray).write(to: URL(string: "file://\(url.absoluteString)")!)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
