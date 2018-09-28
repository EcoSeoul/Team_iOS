//
//  FranchiseDetailService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct FranchiseDetailService: GettableService {
    
    typealias NetworkData = FranchiseDetail
    static let shareInstance = FranchiseDetailService()
    
    func getFranchiseDetailData(url : String, completion : @escaping (NetworkResult<FranchiseDetailData>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "OK" :
                    completion(.networkSuccess(networkResult.frcInfo[0]))
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
