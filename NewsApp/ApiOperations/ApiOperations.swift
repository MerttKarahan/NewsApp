//
//  ApiOperations.swift
//  NewsApp
//
//  Created by Mert Karahan on 29.06.2022.
//

import Foundation
import Alamofire

struct Constants {
    static var baseUrl = "https://newsapi.org/v2/"
    static var headers : HTTPHeaders = ["X-Api-Key" : "2e3b384b237a453186aaf140bf5d8c8c"]
    static var countryCategory : [String : Any] = ["country" : "", "category" : ""]
    
}


enum NewsPaths: String {
    case topHeadlines = "top-headlines"

    
    var fullPath : String {
        return Constants.baseUrl + self.rawValue
    }
}

class ApiOperations {
    
    static var sharedInstance = ApiOperations()
    
//    To do Encodable çevir.
    func getNews(country:String, category:String, finishGetNews: @escaping ((Result<NewsItemsResponse, AFError>) -> Void)) {
        
        var countryCategory = Constants.countryCategory
        countryCategory["country"] = country
        countryCategory["category"] = category
        
        
        let request = AF.request(NewsPaths.topHeadlines.fullPath,
                                 method: .get,
                                 parameters: countryCategory,
                                 encoding: URLEncoding.default,
                                 headers: Constants.headers)
        
        request.responseDecodable(of: NewsItemsResponse.self) { response in
            if let value = response.value {
                finishGetNews(.success(value))
            } else if let error = response.error {
                finishGetNews(.failure(error))
            }
        }
    }
}





