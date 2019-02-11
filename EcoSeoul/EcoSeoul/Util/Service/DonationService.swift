//  DonationService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct DonationService: PostableService {
    
    typealias NetworkData = Default
    static let shareInstance = DonationService()
    
    func donate(url : String, params : [String : Any], completion : @escaping (NetworkResult<Default>) -> Void){
        post(url, params: params) { (result) in
            
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Donate and Update Mileage" :
                    completion(.networkSuccess(networkResult))
                    break
                case "The user's mileage is insufficient" :
                    completion(.nullValue)
                    break
                    //completion(.wrongInput)
                    //case "500 Error" :
                //    completion(.serverErr)
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
