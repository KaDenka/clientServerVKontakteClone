//
//  NewsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 08.08.2021.
//

import UIKit


class NewsViewController: UIViewController, UITableViewDataSourcePrefetching {
    
    
    
    let newsList = NewsAPIService()
    
    let infoPostNib = UINib(nibName: "InfoPostTableViewCell", bundle: nil)
    let postTextNib = UINib(nibName: "PostTextTableViewCell", bundle: nil)
    let commentsLikesNib = UINib(nibName: "CommentsLikesTableViewCell", bundle: nil)
    
    var news = [ResponseItem]()
    var newsUsers = [Profile]()
    var newsGroups = [NewsGroup]()
    
    var nextFrom = ""
    var isLoading = false
    
    var expandedIndexSet: IndexSet = []
    
    
    @IBOutlet weak var newsTableView: UITableView! {
        didSet {
            newsTableView.delegate = self
            newsTableView.dataSource = self
            newsTableView.register(infoPostNib, forCellReuseIdentifier: "infoPostCell")
            newsTableView.register(postTextNib, forCellReuseIdentifier: "postTextCell")
            newsTableView.register(commentsLikesNib, forCellReuseIdentifier: "commentsLikesCell")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTableView.prefetchDataSource = self
        
        self.newsTableView.refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
        
        
        
        newsList.newsAPIRequest { [weak self] responseItems, profiles, newsGroups in
            
            guard let self = self else { return }
            
            self.news = responseItems
            self.newsUsers = profiles
            self.newsGroups = newsGroups
            
            self.newsTableView.reloadData()
            
        }
        
    
        
        self.newsTableView.reloadData()
        
    }
    
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionNewsFeed = news[section]
        
        if sectionNewsFeed.text != nil {
            return 3
        } else {
            return 2
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionNewsFeed = news[indexPath.section]
        
        switch indexPath.row {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoPostCell", for: indexPath) as! InfoPostTableViewCell
            let id = sectionNewsFeed.sourceID!
            if id < 0 {
                var groupProfile: NewsGroup?
                for i in newsGroups {
                    if abs(id) == i.id{
                        groupProfile = i
                    }
                }
                cell.userInfoLabel.text = groupProfile?.name
                if let date = sectionNewsFeed.date {
                    cell.dateInfoLabel.text = convertDate(date: date)
                }
                if let photoString = groupProfile?.photo50 {
                    let url = URL(string: photoString)!
                    if let data = try? Data(contentsOf: url) {
                        let image = UIImage(data: data)
                        cell.userAvatarImage.image = image
                    } else {
                        cell.userAvatarImage.image = UIImage(named: "defaultUserAvatar")
                    }
                } else {
                    var userProfile: Profile?
                    for i in newsUsers {
                        if abs(id) == i.id {
                            userProfile = i
                        }
                    }
                    cell.userInfoLabel.text = "\(userProfile?.firstName ?? "") \(userProfile?.lastName ?? "")"
                    if let date = sectionNewsFeed.date {
                        cell.dateInfoLabel.text = convertDate(date: date)
                    }
                    if let photoString = userProfile?.photo50 {
                        let url = URL(string: photoString)!
                        if let data = try? Data(contentsOf: url) {
                            let image = UIImage(data: data)
                            cell.userAvatarImage.image = image
                        } else {
                            cell.userAvatarImage.image = UIImage(named: "defaultUserAvatar")
                        }
                    }
                }
            }
            return cell
        case 1:
            if sectionNewsFeed.text != nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: "postTextCell", for: indexPath) as! PostTextTableViewCell
                cell.postTextLabel.text = sectionNewsFeed.text
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "commentsLikesCell", for: indexPath) as! CommentsLikesTableViewCell
                cell.commentsCount.text = "\(sectionNewsFeed.comments?.count ?? 0)"
                cell.commentsLabel.text = "Comments"
                cell.likesCount.text = "\(sectionNewsFeed.likes?.count ?? 0)"
                cell.likesImage.image = UIImage(systemName: "heart.fill")
                return cell
            }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentsLikesCell", for: indexPath) as! CommentsLikesTableViewCell
            cell.commentsCount.text = "\(sectionNewsFeed.comments?.count ?? 0)"
            cell.commentsLabel.text = "Comments"
            cell.likesCount.text = "\(sectionNewsFeed.likes?.count ?? 0)"
            cell.likesImage.image = UIImage(systemName: "heart.fill")
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        
        if maxSection > news.count - 5, !isLoading {
            
            isLoading = true
            
            newsList.newsAPIRequest(startFrom: nextFrom) { [weak self] newsItems, usersItems, groupsItems in
                
                guard let self = self else { return }
                
                let indexSet = IndexSet(integersIn: self.news.count..<self.news.count + newsItems.count)
                
                self.news.append(contentsOf: newsItems)
                self.newsUsers.append(contentsOf: usersItems)
                self.newsGroups.append(contentsOf: groupsItems)
                
                self.newsTableView.insertSections(indexSet, with: .automatic)
                
                self.isLoading = false
            }
        }
    }
    
    @objc func refreshNews(sender: AnyObject) {
        self.newsTableView.refreshControl?.beginRefreshing()
        
        let mostRecentFeedItemDate = self.news.first?.date ?? Date().timeIntervalSince1970
        
        newsList.newsAPIRequest(startTime: mostRecentFeedItemDate + 1){ [weak self] newsItems, usersItems, groupsItems in
            
            guard let self = self else { return }
            
            self.newsTableView.refreshControl?.endRefreshing()
            self.news = newsItems + self.news
            self.newsUsers = usersItems + self.newsUsers
            self.newsGroups = groupsItems + self.newsGroups
            let indexSet = IndexSet(integersIn: 0..<newsItems.count)
            self.newsTableView.insertSections(indexSet, with: .fade)
        }
    }
    
}


func convertDate(date: TimeInterval) -> String {
    
    let dateFormat = Date(timeIntervalSince1970: date)
    
    let dayTimePeriodFormatter = DateFormatter()
    
    dayTimePeriodFormatter.dateFormat = " hh:mm dd.MM.YY"
    
    let dateString = dayTimePeriodFormatter.string(from: dateFormat)
    
    return dateString
}





