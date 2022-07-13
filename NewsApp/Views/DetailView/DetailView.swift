//
//  DetailView.swift
//  NewsApp
//
//  Created by Mert Karahan on 6.07.2022.
//

import UIKit

protocol AnyDetailView {
    var detailPresenter: AnyDetailPresenter? {get set}
    
}

class DetailView: UIViewController, AnyDetailView {
    
    var detailPresenter: AnyDetailPresenter?

    @IBOutlet private weak var detialName: UILabel!
    @IBOutlet weak var detailContent: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailPublishedAt: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    private func configure() {
        
        detailTitle.text = detailPresenter?.newsItem.title
        detailContent.text = detailPresenter?.newsItem.content
        detailPublishedAt.text = detailPresenter?.newsItem.publishedAt
        detailDescription.text = detailPresenter?.newsItem.description
        detialName.text = detailPresenter?.newsItem.source.name
        detailImage.setImage(urlToImage: detailPresenter?.newsItem.urlToImage ?? "")
    }
    
}
