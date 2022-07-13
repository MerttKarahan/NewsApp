//
//  HomeRouter.swift
//  NewsApp
//
//  Created by Mert Karahan on 28.06.2022.
//

import Foundation
import UIKit

typealias EntryPoint = AnyHomeView & UIViewController

protocol AnyHomeRouter {
    var entry: EntryPoint? {get}
    
    static func start() -> UIViewController?
    
    func getNewsDetail(response: NewsItem)
}


class HomeRouter: AnyHomeRouter {
    
    var entry: EntryPoint?

    static func start() -> UIViewController? {
        let router = HomeRouter()
        
        var view: AnyHomeView = HomeView()
        var presenter: AnyHomePeresenter = HomePresenter()
        var interactor: AnyHomeInteractor = HomeInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return view as? UIViewController
    }
    
    func getNewsDetail(response: NewsItem) {
    
        if let viewController = DetailBuilder.buildDetail(response: response) {
            entry?.navigationController?.pushViewController(viewController, animated: true)
        }
    }

}



