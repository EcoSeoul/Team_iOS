//
//  List.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct RequestList: Codable{
    let message: String
    let myGoods: [RequestListData]
    
    enum CodingKeys: String, CodingKey{
        case message = "message"
        case myGoods = "myGoods"
    }
}

struct RequestListData: Codable{
    let goodsName: String
    let mileageWithdraw: Int
    let mileageDate: String
    let mileageUsage: String

    enum CodingKeys: String, CodingKey{
        case goodsName = "goods_name"
        case mileageWithdraw = "mileage_withdraw"
        case mileageDate = "mileage_date"
        case mileageUsage = "mileage_usage"
    }
}

//Example
//{
//    "message": "Successfully Get Goods Data",
//    "myGoods": [
//    {
//    "goods_name": "민형이의 멋잠",
//    "mileage_withdraw": 3500,
//    "mileage_date": "2018-09-24",
//    "mileage_usage": "민형이의 멋잠 구매"
//    }
//    ]
//}

//==================================================

struct DonationList: Codable{
    let message: String
    let myTotalMileage: Int
    let myDonations: [DonationListData]
    
    enum CodingKeys: String, CodingKey{
        case message = "message"
        case myTotalMileage = "myTotalMileage"
        case myDonations = "myDonations"
    }
}

struct DonationListData: Codable{
    let orgName: String
    let mileageWithdraw: Int
    let mileageDate: String
    
    enum CodingKeys: String, CodingKey{
        case orgName = "org_name"
        case mileageWithdraw = "mileage_withdraw"
        case mileageDate = "mileage_date"
        
    }
}

//Example
//{
//    "message": "Successfully Get Organizations Data",
//    "myTotalMileage": 20000,
//    "myDonations": [
//    {
//    "org_name": "서울시청",
//    "mileage_withdraw": 1000,
//    "mileage_date": "2018-09-24"
//    }
//    ]
//}


//==================================================

struct PostList: Codable{
    let message: String
    let myTextList: [PostListData]
    
    enum CodingKeys: String, CodingKey{
        case message = "message"
        case myTextList = "mytext_list"
    }
}

struct PostListData: Codable{
    let boardIdx: Int
    let boardTitle: String
    let boardContent: String
    let boardDate: String
    let userIdx: Int
    let boardLike: Int?
    let userName: String
    let boardCmtNum: Int?
    
    enum CodingKeys: String, CodingKey{
        case boardIdx = "board_idx"
        case boardTitle = "board_title"
        case boardContent = "board_content"
        case boardDate = "board_date"
        case userIdx = "user_idx"
        case boardLike = "board_like"
        case userName = "user_name"
        case boardCmtNum = "board_cmtnum"
    }
}

//Example
//{
//    "message": "ok",
//    "mytext_list": [
//    {
//    "board_idx": 17,
//    "board_title": "예은이는 졸려요",
//    "board_content": "벌써 4시네요",
//    "board_date": "2018-09-27T18:53:29.000Z",
//    "user_idx": 1,
//    "board_like": null,
//    "user_name": "timti",
//    "board_cmtnum": null
//}



