//
//  NewsItem.swift
//  iOSNews
//
//  Created by 서종철 on 6/17/24.
//

import Foundation

struct NewsItem: Decodable {
    let title: String
    let description: String?
    let urlToImage: String?
    let publishedAt: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case url
        case publishedAt
    }
}

struct NewsResponse: Decodable {
    let articles: [NewsItem]
}
