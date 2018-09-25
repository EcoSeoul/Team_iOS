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
    
    typealias NetworkData = LoginData
    static let shareInstance = LoginService()
    
    func login(url : String, params : [String : Any], completion : @escaping (NetworkResult<Any>) -> Void){
        
        post(url, params: params) { (result) in
      
            switch result {
                
                case .success(let networkResult):
                    
//                    print("\n서버로부터받은결과값 출력!\n")
//                    print("\(networkResult)\n")
                    
                    switch networkResult.message {
                        case "Login Success" :
                            completion(.networkSuccess(networkResult.checkResult[0]))
                        case "400 Error" :
                            completion(.nullValue)
                            //completion(.wrongInput)
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
