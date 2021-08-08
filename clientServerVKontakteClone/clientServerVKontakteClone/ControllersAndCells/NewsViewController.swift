//
//  NewsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 08.08.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    let newsList = NewsAPIService()
    
    var news = [ResponseItem]()
    var newsUsers = [Profile]()
    var newsGroups = [NewsGroup]()
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.delegate = self
            newsTableView.dataSource = self
            newsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "newsTableViewCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsList.newsAPIRequest { [weak self] responseItems, profiles, newsGroups in
            
            guard let self = self else { return }
            
            self.news = responseItems
            self.newsUsers = profiles
            self.newsGroups = newsGroups
            
            self.newsTableView.reloadData()
        
        }
        
        // Do any additional setup after loading the view.
    }
    
   
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath)
        let post = news[indexPath.row]
        
        cell.textLabel?.text = "текст новости: \(post.text ?? "")"
    
        return cell
    }
    
    
}
