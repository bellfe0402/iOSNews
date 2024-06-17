//
//  NewsViewModel.swift
//  iOSNews
//
//  Created by 서종철 on 6/17/24.
//

import Foundation
import Alamofire

class NewsViewModel {
    private var newsList: [NewsItem] = []

    var numberOfNews: Int {
        return newsList.count
    }

    func news(at index: Int) -> NewsItem {
        return newsList[index]
    }

    func fetchNews(completion: @escaping () -> Void) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=kr&apiKey=abeace9d149045879d432af894599239"

        AF.request(urlString).responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let newsResponse):
                self.newsList = newsResponse.articles
                completion()
            case .failure(_):
                completion()
            }
        }
    }
}
