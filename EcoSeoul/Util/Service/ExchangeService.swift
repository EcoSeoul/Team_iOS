//
//  ExchangeService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

struct ExchangeService: PostableService {
    
    typealias NetworkData = Exchange
    static let shareInstance = ExchangeService()
    
    func exchange(url : String, params : [String : Any], completion : @escaping (NetworkResult<Exchange>) -> Void){
        
        post(url, params: params) { (result) in
            
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Exchange Mileage to Money" :
                    completion(.networkSuccess(networkResult))
                case "Null Value : user index and exchange" :
                    completion(.nullValue)
                case "You can exchange money only if you have more than 20,000 points in mileage." :
                    print("보유 마일리지가 최소 2만이 넘어야 환전가능!")
                    //completion(.wrongInput)
                case "Insufficient miles to switch" :
                    print("돈이 없음..")
                case "500 Error" :
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
