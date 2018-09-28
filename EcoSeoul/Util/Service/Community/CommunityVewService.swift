//
//  CommunityVewService.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityViewService: GettableService {
    
    typealias NetworkData = CommunityView
    static let shareInstance = CommunityViewService()
    
    func getCommunityDetailData(url : String, completion : @escaping (NetworkResult<CommunityView>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Success" :
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
