//
//  FranchiseService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

struct FranchiseService: GettableService {
    
    typealias NetworkData = Franchise
    static let shareInstance = FranchiseService()
    
    func getFranchiseData(url : String, completion : @escaping (NetworkResult<[FranchiseData]>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "ok" :
//                    print("\n서버로부터 받은 프렌차이즈 정보 출력!\n")
//                    print("\(networkResult)\n")
                    completion(.networkSuccess(networkResult.data))
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
