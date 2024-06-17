//
//  MainViewController.swift
//  iOSNews
//
//  Created by 서종철 on 6/17/24.
//

import UIKit
import Then
import SnapKit
import Alamofire

class MainViewController: UIViewController {
    let viewModel = NewsViewModel()
    var selectedIndexPaths: Set<IndexPath> = []
    
    let tableView = UITableView().then {
        $0.register(NewsItemCell.self, forCellReuseIdentifier: NewsItemCell.identifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchNews()
    }

    private func setupViews() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func fetchNews() {
        viewModel.fetchNews {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNews
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsItemCell.identifier, for: indexPath) as! NewsItemCell
        cell.configure(with: viewModel.news(at: indexPath.row))
        
        if selectedIndexPaths.contains(indexPath) {
            cell.titleLabel.textColor = .red
        } else {
            cell.titleLabel.textColor = .black
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = viewModel.news(at: indexPath.row)

        let webViewController = WebViewController()
        webViewController.newsURL = news.url
        webViewController.newsTitle = news.title
        webViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(webViewController, animated: true)

        selectedIndexPaths.insert(indexPath)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
