//
//  PostListService.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct PostListService: GettableService {
    
    typealias NetworkData = PostList
    static let shareInstance = PostListService()
    
    func getPostData(url : String, completion : @escaping (NetworkResult<[PostListData]>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "ok" :
                    completion(.networkSuccess(networkResult.myTextList))
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
