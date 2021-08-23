//
//  News.swift
//  clientServerVKontakteClone
//
//  Created by Denis Kazarin on 08.08.2021.
//
import Foundation

// MARK: - News
struct News: Codable {
    let response: NewsResponse?
}

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let items: [ResponseItem]?
    let profiles: [Profile]?
    let groups: [NewsGroup]?
    let nextFrom: String?
    
    enum CodingKeys: String, CodingKey {
        case items, profiles, groups
        case nextFrom = "next_from"
    }
}

// MARK: - ResponseItem
struct ResponseItem: Codable {
    let sourceID: Int?
    let date: TimeInterval?
    let postType: String?
    let text: String?
    let attachments: [Attachment]?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?
    let friends: NewsFriends?
    let signerID: Int?
    
    // let canDoubtCategory, canSetCategory: Bool?
    // let markedAsAds: Int?
    // let postSource: PostSource?
    // let isFavorite: Bool?
    // let donut: Donut?
    // let shortTextRate: Double?
    // let postID: Int?
    // let type: String?
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case postType = "post_type"
        case text
        case attachments
        case comments, likes, reposts, views
        case friends
        case signerID = "signer_id"
        
        //case canDoubtCategory = "can_doubt_category"
        // case canSetCategory = "can_set_category"
        //case markedAsAds = "marked_as_ads"
        //case postSource = "post_source"
        //case isFavorite = "is_favorite"
        //case donut
        //case shortTextRate = "short_text_rate"
        // case postID = "post_id"
        // case type,
        
    }
}

// MARK: - Profile
struct Profile: Codable {
    let firstName: String?
    let id: Int?
    let lastName: String?
    let screenName: String?
    let photo50: String?
    //let canAccessClosed, isClosed: Bool?
    //let sex: Int?
    //let photo100: String?
    //let onlineInfo: OnlineInfo?
    //let online: Int?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case screenName = "screen_name"
        case photo50 = "photo_50"
        //case canAccessClosed = "can_access_closed"
        //case isClosed = "is_closed"
        //case sex
        //case photo100 = "photo_100"
        //case onlineInfo = "online_info"
        //case online
    }
}



// MARK: - NewsGroup
struct NewsGroup: Codable {
    let id: Int?
    let name, screenName: String?
    let photo50: String?
    //let isClosed: Int?
    //let type: String?
    //let isAdmin, isMember, isAdvertiser: Int?
    //let photo100, photo200: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case photo50 = "photo_50"
        //case isClosed = "is_closed"
        //case type
        //case isAdmin = "is_admin"
        //case isMember = "is_member"
        //case isAdvertiser = "is_advertiser"
        //case photo100 = "photo_100"
        //case photo200 = "photo_200"
    }
}


// MARK: - Attachment
struct Attachment: Codable {
    let type: String?
    let video: Video?
    let photo: NewsPhoto?
}

// MARK: - NewsPhoto
struct NewsPhoto: Codable {
    let albumID, date, id, ownerID: Int?
    let sizes: [ContentSize]?
    let text: String?
    let userID: Int?
    //let hasTags: Bool?
    //let accessKey: String?
    //let postID: Int?
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes, text
        case userID = "user_id"
        //case hasTags = "has_tags"
        //case accessKey = "access_key"
        //case postID = "post_id"
    }
}

// MARK: - ContentSize
struct ContentSize: Codable {
    let height: Int?
    let url: String?
    let type: String?
    let width, withPadding: Int?
    
    enum CodingKeys: String, CodingKey {
        case height, url, type, width
        case withPadding = "with_padding"
    }
}

// MARK: - Video
struct Video: Codable {
    let accessKey: String?
    let canComment, canLike, canRepost, canSubscribe: Int?
    let canAddToFaves, canAdd, comments, date: Int?
    let videoDescription: String?
    let duration: Int?
    let image, firstFrame: [ContentSize]?
    let width, height, id, ownerID: Int?
    let title: String?
    let isFavorite: Bool?
    let trackCode, type: String?
    let views: Int?
    
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case comments, date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case isFavorite = "is_favorite"
        case trackCode = "track_code"
        case type, views
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int?
    let groupsCanPost: Bool?
    
    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}



// MARK: - NewsFriends
struct NewsFriends: Codable {
    let count: Int?
    let items: [FriendsItem]?
}

// MARK: - FriendsItem
struct FriendsItem: Codable {
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes, canLike, canPublish: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}



// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int?
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int?
}


// MARK: - OnlineInfo
//struct OnlineInfo: Codable {
//    let visible, isOnline, isMobile: Bool?
//    let lastSeen, appID: Int?
//    let status: String?
//
//    enum CodingKeys: String, CodingKey {
//        case visible
//        case isOnline = "is_online"
//        case isMobile = "is_mobile"
//        case lastSeen = "last_seen"
//        case appID = "app_id"
//        case status
//    }
//}

// MARK: - Donut
//struct Donut: Codable {
//    let isDonut: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case isDonut = "is_donut"
//    }
//}

// MARK: - PostSource
//struct PostSource: Codable {
//    let type, platform: String?
//}
