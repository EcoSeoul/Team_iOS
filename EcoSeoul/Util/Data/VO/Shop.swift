//
//  Shop.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 29..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct Shop: Codable {
    let message : String
    let shopData : [ShopData]
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case shopData = "shopData"
    }
}

struct ShopData : Codable {
    let goodsIdx : Int
    let goodsName: String
    let goodsImg : String
    
    enum CodingKeys: String, CodingKey {
        case goodsIdx = "goods_idx"
        case goodsName = "goods_name"
        case goodsImg = "goods_img"
    }
}

struct ShopView: Codable {
    let message : String
    let shopDetail : [ShopDetail]
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case shopDetail = "shopDetail"
    }
}

struct ShopDetail: Codable {
    let goodsIdx : Int
    let goodsName: String
    let goodsCompany: String
    let goodsContent: String
    let goodsPrice: Int
    let goodsImg : String
    let goodsSummery : String
    
    enum CodingKeys:String, CodingKey {
        case goodsIdx = "goods_idx"
        case goodsName = "goods_name"
        case goodsCompany = "goods_company"
        case goodsContent = "goods_content"
        case goodsPrice = "goods_price"
        case goodsImg = "goods_img"
        case goodsSummery = "goods_summery"
    }
}
