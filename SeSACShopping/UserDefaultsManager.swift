//
//  UserDefaultsManager.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/21.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    enum UDKey: String {
        case nickname
        case image
        case searchList
    }
    
    let ud = UserDefaults.standard
    
    var nickname: String {
        get { //가져오고
            ud.string(forKey: UDKey.nickname.rawValue) ?? "profile\(Int.random(in: 1...14))"
        }
        set { //저장하기
            ud.set(newValue ,forKey: UDKey.nickname.rawValue)
        }
    }
    
    var image: String {
        get { //가져오고
            ud.string(forKey: UDKey.image.rawValue) ?? "profile1"
        }
        set { //저장하기
            ud.set(newValue ,forKey: UDKey.image.rawValue)
        }
    }
    
    var searchList: String {
        get { //가져오고
            ud.string(forKey: UDKey.nickname.rawValue) ?? "profile\(Int.random(in: 1...14))"
        }
        set { //저장하기
            ud.set(newValue ,forKey: UDKey.nickname.rawValue)
        }
    }
}
