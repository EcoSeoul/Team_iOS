//
//  PayListService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 27..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MileageListService: GettableService {
    
    typealias NetworkData = MileageList
    static let shareInstance = MileageListService()
    
    func getMileageData(url : String, completion : @escaping (NetworkResult<MileageList>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Get Data" :
                    // print("\n서버로부터 받은 프랜차이즈 상세 정보 출력!\n")
                    // print("\(networkResult)\n")
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
