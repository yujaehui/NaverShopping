//
//  Shopping.swift
//  NaverShopping
//
//  Created by Jaehui Yu on 5/9/24.
//

import Foundation

// MARK: - Shopping
struct Shopping: Hashable, Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Hashable, Codable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productID: String
    let productType, brand: String
    let maker: String
    let category1, category2, category3, category4: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, hprice, mallName
        case productID = "productId"
        case productType, brand, maker, category1, category2, category3, category4
    }
}
