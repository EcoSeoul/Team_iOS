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
                    case "You can exchange money only if you have more than 20,000 points in mileage." :
                        completion(.wrongInput)
                    case "Insufficient miles to switch" :
                        completion(.insufficient)
                    case "The minimum exchange amount is 1000" :
                        completion(.minimumValue)
                    case "Null Value : user index and exchange" :
                        completion(.nullValue)

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
