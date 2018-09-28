//
//  CommunityCommentService.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation

struct CommunityCommentService: PostableService {
    
    typealias NetworkData = Default
    static let shareInstance = CommunityCommentService()
    
    func registercomment(url : String, params : [String : Any], completion : @escaping (NetworkResult<Any>) -> Void){
        
        post(url, params: params) { (result) in
            
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "success" :
                    completion(.networkSuccess(networkResult))
                    //                case "400 Error" :
                    //                    completion(.nullValue)
                    //                //completion(.wrongInput)
                    //                case "500 Error" :
                //                    completion(.serverErr)
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
