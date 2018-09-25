//
//  MainService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 26..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MainService: GettableService {
    
    typealias NetworkData = MainData
    static let shareInstance = MainService()
    
    func getMain(url : String, completion : @escaping (NetworkResult<MainData>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Get Data" :
//                    print("\n서버로부터받은결과값 출력!\n")
//                    print("\(networkResult)\n")
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
