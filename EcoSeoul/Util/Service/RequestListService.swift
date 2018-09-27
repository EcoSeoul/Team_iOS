//
//  RequestListService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

//import Foundation
//import Alamofire
//import SwiftyJSON
//
//struct RequestListService: GettableService {
//    
//    typealias NetworkData = RequestList
//    static let shareInstance = RequestListService()
//    
//    func getMoneyData(url : String, completion : @escaping (NetworkResult<MoneyList>) -> Void){
//        
//        get(url) { (result) in
//            switch result {
//            case .success(let networkResult):
//                switch networkResult.message {
//                case "Successfully Get Data" :
//                    completion(.networkSuccess(networkResult))
//                case "Internal Server Error!" :
//                    completion(.serverErr)
//                default :
//                    break
//                }
//                
//                break
//            case .error(let errMsg) :
//                print(errMsg)
//                break
//            case .failure(_) :
//                completion(.networkFail)
//            }
//        }
//        
//    }
//    
//}
