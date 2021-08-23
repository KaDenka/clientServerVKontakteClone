//
//  NewsViewController.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 08.08.2021.
//

import UIKit


class NewsViewController: UIViewController {
    
    let newsList = NewsAPIService()
    
    let infoPostNib = UINib(nibName: "InfoPostTableViewCell", bundle: nil)
    let postTextNib = UINib(nibName: "PostTextTableViewCell", bundle: nil)
    let commentsLikesNib = UINib(nibName: "CommentsLikesTableViewCell", bundle: nil)
    
    var news = [ResponseItem]()
    var newsUsers = [Profile]()
    var newsGroups = [NewsGroup]()
    
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
        
        newsList.newsAPIRequest { [weak self] responseItems, profiles, newsGroups in
            
            guard let self = self else { return }
            
            self.news = responseItems
            self.newsUsers = profiles
            self.newsGroups = newsGroups
            
            self.newsTableView.reloadData()
            
        }
        
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
    
}


func convertDate(date: TimeInterval) -> String {
    
    let dateFormat = Date(timeIntervalSince1970: date)
    
    let dayTimePeriodFormatter = DateFormatter()
    
    dayTimePeriodFormatter.dateFormat = " hh:mm dd.MM.YY"
    
    let dateString = dayTimePeriodFormatter.string(from: dateFormat)
    
    return dateString
}


