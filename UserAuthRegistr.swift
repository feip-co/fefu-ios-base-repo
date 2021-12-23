//
//  UserAuthRegistr.swift
//  HomeTask_3
//
//  Created by wsr5 on 23.12.2021.
//

import Foundation

class UserAuthRegistr {
    
    static let instance = UserAuthRegistr()

    private let defaults = UserDefaults.standard

    static let userNameKey = "userName"
    static let userPasswordKey = "userPassword"
    static let userKey = "userKey"

    private init() {}

    func saveUser(login: String, password: String, key: String) {
        saveKey(keyValue: login, typeOfKey: UserAuthRegistr.userNameKey)
        saveKey(keyValue: password, typeOfKey: UserAuthRegistr.userPasswordKey)
        saveKey(keyValue: key, typeOfKey: UserAuthRegistr.userKey)
    }

    func saveKey(keyValue: String, typeOfKey: String) {
        defaults.setValue(keyValue, forKey: typeOfKey)
    }

    func getKey(nameOfKey: String) -> String? {
        return defaults.string(forKey: nameOfKey)
    }

    func deleteKey(nameOfKey: String) {
        defaults.removeObject(forKey: nameOfKey)
    }

}
