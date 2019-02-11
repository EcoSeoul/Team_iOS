//
//  CardService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CardService: PostableService {
    
    typealias NetworkData = Default
    static let shareInstance = CardService()
    
    func card(url : String, params : [String : Any], completion : @escaping (NetworkResult<Default>) -> Void){
        
        post(url, params: params) { (result) in
            
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                    case "Successfully Insert BarcodeNumber" :
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
