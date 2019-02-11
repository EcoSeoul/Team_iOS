//
//  DonationListServic.swift
//  EcoSeoul
//
//  Created by 이충신 on 2018. 9. 28..
//  Copyright © 2018년 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct DonationListService: GettableService {
    
    typealias NetworkData = DonationList
    static let shareInstance = DonationListService()
    
    func getDonationData(url : String, completion : @escaping (NetworkResult<[DonationListData]>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.message {
                case "Successfully Get Organizations Data" :
                    completion(.networkSuccess(networkResult.myDonations))
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
