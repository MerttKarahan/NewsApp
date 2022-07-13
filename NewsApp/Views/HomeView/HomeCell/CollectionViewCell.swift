//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Mert Karahan on 28.06.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var publishedAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configure(newsItem: NewsItem) {
        title.text = newsItem.title
        name.text = newsItem.source.name
        publishedAt.text = newsItem.publishedAt
        newsImage.setImage(urlToImage: newsItem.urlToImage ?? "")
    }

}
