//
//  HomeEntity.swift
//  NewsApp
//
//  Created by Mert Karahan on 28.06.2022.
//

import Foundation

struct NewsItem: Decodable {
    
    let urlToImage: String?
    let title: String?
    let publishedAt: String?
    let description: String?
    let content: String?
    let source : Source
}

struct Source: Decodable {
    let name: String?
}

struct NewsItemsResponse : Decodable {
    var status : String
    var totalResults : Int
    var articles : [NewsItem]
}
