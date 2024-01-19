//
//  Shopping.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/18.
//

import Foundation

// MARK: - Shopping
struct Shopping: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productID: String
    let productType, brand, maker: String
}
