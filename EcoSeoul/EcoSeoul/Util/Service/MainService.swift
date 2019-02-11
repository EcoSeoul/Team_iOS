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
    
    typealias NetworkData = Main
    static let shareInstance = MainService()
    
    func getMain(url : String, completion : @escaping (NetworkResult<Main>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Get Data" :
                    completion(.networkSuccess(networkResult))
                case "Null Value : User Index" :
                    completion(.nullValue)
                case "IInternal Server Error : XXX" :
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
