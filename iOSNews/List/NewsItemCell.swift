//
//  NewsItemCell.swift
//  iOSNews
//
//  Created by 서종철 on 6/17/24.
//

import Foundation
import UIKit
import Then
import SnapKit
import Kingfisher

class NewsItemCell: UITableViewCell {
    static let identifier = "NewsItemCell"
    
    let newsImageView = UIImageView().then {
       $0.contentMode = .scaleAspectFill
       $0.clipsToBounds = true
       $0.layer.cornerRadius = 5
    }

    let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.numberOfLines = 2
        $0.textColor =  UIColor(hex: 0x000000)
    }

    let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 2
        $0.textColor =  UIColor(hex: 0x333333)
    }
    
    let publishedAtLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 9)
        $0.numberOfLines = 1
        $0.textColor =  UIColor(hex: 0xCCCCCC)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(publishedAtLabel)
        
        newsImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(newsImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(newsImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.greaterThanOrEqualTo(30)
        }
        
        publishedAtLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.leading.equalTo(newsImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }

    func configure(with news: NewsItem) {
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        publishedAtLabel.text = formatDate(news.publishedAt)
        loadImage(from: news.urlToImage ?? "")
    
    }
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }

        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "yyyy년 M월 d일 HH시 mm분"
        return displayFormatter.string(from: date)
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            newsImageView.image = UIImage(systemName: "photo")
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.newsImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.newsImageView.image = UIImage(systemName: "photo")
                }
            }
        }
    }
}
