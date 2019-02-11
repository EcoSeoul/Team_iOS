//
//  ShopDetailService.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 29..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ShopDetailService: GettableService {
    
    typealias NetworkData = ShopView
    static let shareInstance = ShopDetailService()
    
    func getShopDetailData(url : String, completion : @escaping (NetworkResult<ShopView>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Get Data" :
                    completion(.networkSuccess(networkResult))
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
