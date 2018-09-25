//
//  LoginData.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 25..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct LoginData: Codable {
    let status : Bool
    let message: String
    let checkResult : LoginVO
}
