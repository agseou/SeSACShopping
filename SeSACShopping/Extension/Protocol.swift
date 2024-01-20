//
//  Protocol.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/18.
//

import UIKit

protocol autoCompletion {
    static var identifier: String { get }
}

extension UIViewController: autoCompletion {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: autoCompletion {
    static var identifier: String {
        return String(describing: self)
    }
}
extension UICollectionViewCell: autoCompletion {
    static var identifier: String {
        return String(describing: self)
    }
}

