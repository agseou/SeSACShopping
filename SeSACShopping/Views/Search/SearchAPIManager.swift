//
//  SearchAPIManager.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/21.
//

import Foundation
import Alamofire

class SearchAPIManager {
    
    
    let headers: HTTPHeaders = [
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        "X-Naver-Client-Id": APIKey.clientID,
        "X-Naver-Client-Secret": APIKey.clientSecret]
    
    
    func callRequest(text: String, sort: String) async throws -> Shopping {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=20&start=1&sort=\(sort)"
        
        let parameters: Parameters = [
            "query": query
        ]
        
        return try await AF.request(url,
                                    method: .get,
                                    parameters: parameters,
                                    headers: headers)
        .validate(statusCode: 200..<300)
        .serializingDecodable(Shopping.self)
        .value
    }
    
    func callRequest(text: String, start: Int, sort: String ,completionHandler: @escaping (Shopping) -> Void){
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(query)&display=20&start=\(start)&sort=\(sort)"
        
        let parameters: Parameters = [
            "query": query
        ]
       
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers).responseDecodable(of: Shopping.self) { response in
            switch response.result {
            case .success(let success):
                if start == 1 {
                    completionHandler(success)
                } else {
                    completionHandler(success)
                }
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
}
