//
//  DetailBuilder.swift
//  NewsApp
//
//  Created by Mert Karahan on 11.07.2022.
//

import Foundation
import UIKit

struct DetailBuilder {
    static func buildDetail(response: NewsItem) -> UIViewController? {
        let detailRouter: AnyDetailRouter = DetailRouter()
        var detailView: AnyDetailView = DetailView()
        var detailPresenter: AnyDetailPresenter = DetailPresenter(newsItem: response)
        
        detailView.detailPresenter = detailPresenter
        detailPresenter.detailView = detailView
        detailPresenter.detailRouter = detailRouter
        
        return detailView as? UIViewController
    }
}
