//
//  APIService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 25..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

protocol APIService {}

extension APIService {
    func url(_ path: String) -> String {
        return "http://13.124.75.47:3000" + path
    }
    
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
}

