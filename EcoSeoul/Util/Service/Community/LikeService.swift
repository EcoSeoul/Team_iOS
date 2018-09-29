//
//  BookmarkService.swift
//  EcoSeoul
//
//  Created by 조예은 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
struct LikeService : PostableService {
    
    typealias NetworkData = Default
    static let shareInstance = LikeService()
    
    func checkLike(URL : String, params : [String : Any], completion : @escaping (NetworkResult<Default>) -> Void) {
        post(URL, params: params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                    case "Successfully Add Thumb" :
                        completion(.networkSuccess(networkResult))
                    case "Successfully Delete Thumb":
                        completion(.networkSuccess(networkResult))
                    default :break
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
