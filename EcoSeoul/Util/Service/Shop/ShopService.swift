//
//  ShopService.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 29..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ShopService: GettableService {
    typealias NetworkData = Shop
    static let shareInstance = ShopService()
    
    func shopInit(url : String, completion : @escaping (NetworkResult<Shop>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Get Data" :
                    completion(.networkSuccess(networkResult))
                case "Internal Server Error!" :
                    completion(.serverErr)
                default :
                    break
                }
                
                break
            case .error(let errMsg) :
                print(errMsg)
                break
            case .failure(_) :
                completion(.networkFail)
            }
        }
        
    }
    
}
