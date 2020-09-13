//
//  SwiftNewsViewController.swift
//  SwiftNews
//
//  Created by Jeffrey Ip on 2020-09-11.
//  Copyright © 2020 none. All rights reserved.
//

import UIKit

class SwiftNewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let swiftNewsUrl = URL(string: "https://www.reddit.com/r/swift/.json")
    var newsItems = [SwiftNewsItem]()
    let cellId = "SwiftNewsTableViewCell"
    let cellHeight: CGFloat = 208.0
    let imageLoader = ImageLoader()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        getSwiftNewsData()
    }
    
    private func setupNavigationBar() {
        title = "Swift News"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 248.0/255.0, green: 73.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    // MARK: - Networking
    
    private func getSwiftNewsData() {
        if let url = swiftNewsUrl {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {
                data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                        let swiftNewsData = decodedResponse.data.children
                        let swiftNewsItems = swiftNewsData.map { $0.data }
                        self.newsItems = swiftNewsItems
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        return
                    }
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        }
    }

    // MARK: - TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SwiftNewsTableViewCell
        let newsItem = newsItems[indexPath.row]
        cell.newsTitleLabel.text = newsItem.title
        if let url = newsItem.thumbnailUrl {
            cell.thumbnailImageView.loadImage(at: url)
        }
        return cell
    }

    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        pushSwiftNewsDetailViewcontroller(with: newsItems[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if newsItems[indexPath.row].thumbnailUrl != nil {
            return cellHeight
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    // MARK: - Navigation
    
    func pushSwiftNewsDetailViewcontroller(with newsItem: SwiftNewsItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SwiftNewsDetailViewController") {
            (vc as! SwiftNewsDetailViewController).swiftNewsItem = newsItem
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
