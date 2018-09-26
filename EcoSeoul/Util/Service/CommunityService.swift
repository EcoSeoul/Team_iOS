//
//  CommunityService.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 26..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityService: GettableService {
    
    typealias NetworkData = Community
    static let shareInstance = CommunityService()
    
    func getCommunityData(url : String, completion : @escaping (NetworkResult<Community>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "OK" :
                     print("\n서버로부터 받은 커뮤니티 정보 출력!\n")
                     print("\(networkResult)\n")
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
