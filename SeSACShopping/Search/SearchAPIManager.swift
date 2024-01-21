//
//  SearchAPIManager.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/21.
//

import Foundation
import Alamofire

struct SearchAPIManager {
    func callRequest(text: String, completionHandler: @escaping ([Item]) -> Void){
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(text)"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret]
        
        AF.request(url,
                   method: .get,
                   headers: headers).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                completionHandler(success.items)
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
}
