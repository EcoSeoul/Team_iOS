//
//  ShopApplyService.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 29..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct ShopApplyService: PostableService {
    
    typealias NetworkData = Default
    static let shareInstance = ShopApplyService()
    
    func applyitem(url : String, params : [String : Any], completion : @escaping (NetworkResult<Any>) -> Void){
        
        post(url, params: params) { (result) in
            
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Donate and Update Milage" :
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
