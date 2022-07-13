//
//  HomePresenter.swift
//  NewsApp
//
//  Created by Mert Karahan on 28.06.2022.
//

import Foundation


protocol AnyHomePeresenter {
    var interactor: AnyHomeInteractor? {get set}
    var view: AnyHomeView? {get set}
    var router: AnyHomeRouter? {get set}
    
    var numberOfItems: Int {get}
    var viewType: ViewType {get set}
    var countryList: [String] {get}
    var categoryList: [String] {get}
    var selectedCountry: String {get set}
    var selectedCategory: String {get set}
    var countryDic : [String:String] {get set}
    var categoryDic : [String:String] {get set}


    func interactorDidFetchGeneralNewsTr(result: NewsItemsResponse)
    func interactorDidNotFetchGeneralNewsTr(result: Error)
    func item(at indexPath: IndexPath) -> NewsItem?
    func changeView()
    func getGeneralNewsTr()
    func refreshList()
    func getDetailsFromHomeRouter(index: Int)
}

class HomePresenter: AnyHomePeresenter {
    
    var selectedCountry: String = ""
    var selectedCategory: String = ""
    
    var viewType: ViewType = .tableView
    
    var interactor: AnyHomeInteractor?
    var view: AnyHomeView?
    var router: AnyHomeRouter?
    
    private var result: NewsItemsResponse?
    
    var countryDic : [String:String] = ["Turkey" : "tr", "U.S.A" : "us"]
    
    var categoryDic : [String:String] = ["General" : "general", "Health" : "health", "Science" : "science", "Business" : "business", "Technology" : "technology", "Sport" : "sport"]
    
    var countryList: [String] {
        Array(countryDic.keys)
    }
    
    var categoryList: [String] {
        Array(categoryDic.keys)
    }
    
    func refreshList() {
        let countryValue = countryDic[self.selectedCountry]
        let categoryValue = categoryDic[self.selectedCategory]
        self.interactor?.getNewsFromApiOperations(country: countryValue ?? "", category: categoryValue ?? "")
    }
    

    var numberOfItems: Int {
        self.result?.articles.count ?? 0
    }
    
    func getGeneralNewsTr() {
        self.interactor?.getNewsFromApiOperations(country: "tr", category: "general")
    }
 
    func interactorDidFetchGeneralNewsTr(result: NewsItemsResponse) {
        self.result = result
        self.view?.update()
    }
    
    func interactorDidNotFetchGeneralNewsTr(result: Error) {
    }
    
    func item(at indexPath: IndexPath) -> NewsItem? {
        return result?.articles[indexPath.row]
    }
    
    func getDetailsFromHomeRouter(index: Int) {
        let newsResponse = result?.articles[index]
        router?.getNewsDetail(response: newsResponse!)
    }
    
    func changeView() {
        switch viewType {
        case .collectionView:
            viewType = .tableView
        case .tableView:
            viewType = .collectionView
        }
    }
    
}
