//
//  UserDefaultsManager.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/21.
//

import Foundation

final class UserDefaultsManager {
    
    // 싱글톤 패턴 적용
    static let shared = UserDefaultsManager()
    
    // 열거형을 통해 UserDefaults 유형 관리
    enum UDKey: String {
        case nickname
        case image
        case searchList
        case likes
    }
    
    // UserDefaults 인스턴스의 참조 생성
    let ud = UserDefaults.standard
    
    
    var nickname: String {
        get { ud.string(forKey: UDKey.nickname.rawValue) ?? "User" }
        set { ud.set(newValue ,forKey: UDKey.nickname.rawValue) }
    }
    
    var image: String {
        get {  ud.string(forKey: UDKey.image.rawValue) ?? "profile\(Int.random(in: 1...14))" }
        set { ud.set(newValue ,forKey: UDKey.image.rawValue) }
    }
    
    var searchList: [String]? {
        get {  ud.array(forKey: UDKey.searchList.rawValue) as? [String] }
        set { ud.set(newValue ,forKey: UDKey.searchList.rawValue) }
    }
    
    var likes: [Int]? {
        get {ud.array(forKey: UDKey.likes.rawValue) as? [Int] }
        set { ud.set(newValue ,forKey: UDKey.likes.rawValue) }
    }
}
