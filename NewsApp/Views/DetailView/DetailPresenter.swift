//
//  DetailPresenter.swift
//  NewsApp
//
//  Created by Mert Karahan on 6.07.2022.
//

import Foundation

protocol AnyDetailPresenter {
    
    var detailView: AnyDetailView? {get set}
    var detailRouter: AnyDetailRouter? {get set}
    var newsItem: NewsItem { get set }
    
}

class DetailPresenter: AnyDetailPresenter {
    
    var detailView: AnyDetailView?
    var detailRouter: AnyDetailRouter?
    var newsItem: NewsItem
    
    init(newsItem: NewsItem) {
        self.newsItem = newsItem
    }
    

    
}
