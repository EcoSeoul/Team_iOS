//
//  LoginService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 25..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct LoginService: PostableService {
    
    typealias NetworkData = Login
    static let shareInstance = LoginService()
    
    func login(url : String, params : [String : Any], completion : @escaping (NetworkResult<LoginData>) -> Void){
        
        post(url, params: params) { (result) in
      
            switch result {
                case .success(let networkResult):
                    switch networkResult.message {
                        case "Login Success" :
                            completion(.networkSuccess(networkResult.checkResult[0]))
                        case "400 Error" :
                            completion(.nullValue)
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
