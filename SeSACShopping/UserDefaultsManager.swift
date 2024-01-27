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
        case likes
    }
    
    let ud = UserDefaults.standard
    
    var nickname: String {
        get { //가져오고
            ud.string(forKey: UDKey.nickname.rawValue) ?? "User"
        }
        set { //저장하기
            ud.set(newValue ,forKey: UDKey.nickname.rawValue)
        }
    }
    
    var image: String {
        get { //가져오고
            ud.string(forKey: UDKey.image.rawValue) ?? "profile\(Int.random(in: 1...14))"
        }
        set { //저장하기
            ud.set(newValue ,forKey: UDKey.image.rawValue)
        }
    }
    
    var searchList: [String]? {
        get { //가져오고
            ud.array(forKey: UDKey.searchList.rawValue) as? [String]
        }
        set { //저장하기
            ud.set(newValue ,forKey: UDKey.searchList.rawValue)
        }
    }
    
    var likes: [Item]? {
        get { //가져오고
            ud.array(forKey: UDKey.likes.rawValue) as? [Item]
        }
        set { //저장하기
            ud.set(newValue ,forKey: UDKey.likes.rawValue)
        }
    }
}
