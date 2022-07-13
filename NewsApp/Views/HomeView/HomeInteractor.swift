//
//  HomeInteractor.swift
//  NewsApp
//
//  Created by Mert Karahan on 28.06.2022.
//

import Foundation


protocol AnyHomeInteractor {
    var presenter: AnyHomePeresenter? {get set}
    func getNewsFromApiOperations(country:String, category:String)
}


class HomeInteractor: AnyHomeInteractor {
    
    
    var presenter: AnyHomePeresenter?
    
    func getNewsFromApiOperations(country:String, category:String) {
        
        ApiOperations.sharedInstance.getNews(country: country , category: category) { response in
            switch response {
            case.success(let succesResponse):
                self.presenter?.interactorDidFetchGeneralNewsTr(result: succesResponse)
            case.failure(let error):
                self.presenter?.interactorDidNotFetchGeneralNewsTr(result: error)
                
            }
        }
    }
}


