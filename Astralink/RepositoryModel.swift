//
//  RepositoryModel.swift
//  Astralink
//
//  Created by Asaf Inbar on 29/05/2017.
//  Copyright © 2017 Asaf Inbar. All rights reserved.
//

import UIKit

class RepositoryModel: NSObject, NSCoding {
    var id:NSNumber!
    var ownerName:String?
    var ownerAvatar:String?
    var repoDescription:String?
    var stars:NSNumber?
    var language:String?
    var forks:NSNumber?
    var created_at:Date?
    var htmlUrl:String?
    var isFavorite:Bool = false
    
//    let data = UserDefaults.standard.data(forKey: "favArray")
//    let favArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [RepositoryModel]
//    var favArray:Array<RepositoryModel> = UserDefaults.standard.array(forKey: "favArray") as? Array<RepositoryModel>  ?? [RepositoryModel]()
    
    override init() {
        
    }
    
    init(item:NSDictionary?){
        self.id = item?.object(forKey: "id") as? NSNumber ?? -1
        
        let owner = item?.object(forKey: "owner") as! NSDictionary
        self.ownerName = owner.object(forKey: "login") as? String ?? ""
        self.ownerAvatar = owner.object(forKey: "avatar_url") as? String ?? ""
        
        self.repoDescription = item?.object(forKey: "description") as? String ?? ""
        self.stars = item?.object(forKey: "stargazers_count") as? NSNumber ?? 0
        self.language = item?.object(forKey: "language") as? String ?? ""
        self.forks = item?.object(forKey: "forks_count") as? NSNumber ?? 0
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        self.created_at = dateFormatter.date(from: item?.object(forKey: "created_at") as! String)
        self.htmlUrl = item?.object(forKey: "html_url") as? String ?? ""
        
        //set favorite
        self.isFavorite = UserDefaultsUtils.sharedInstance.isRepositoryFavorite(repoID: self.id)
    }
    
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeObject(forKey: "id") as! NSNumber
        self.ownerName = decoder.decodeObject(forKey: "login") as? String
        self.ownerAvatar = decoder.decodeObject(forKey: "avatar_url") as? String
        self.repoDescription = decoder.decodeObject(forKey: "description") as? String
        self.stars = decoder.decodeObject(forKey: "stargazers_count") as? NSNumber
        self.language = decoder.decodeObject(forKey: "language") as? String
        self.forks = decoder.decodeObject(forKey: "forks_count") as? NSNumber
        self.created_at = decoder.decodeObject(forKey: "created_at") as? Date
        self.htmlUrl = decoder.decodeObject(forKey: "html_url") as? String

    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(ownerName, forKey: "login")
        coder.encode(ownerAvatar, forKey: "avatar_url")
        coder.encode(repoDescription, forKey: "description")
        coder.encode(stars, forKey: "stargazers_count")
        coder.encode(language, forKey: "language")
        coder.encode(forks, forKey: "forks_count")
        coder.encode(created_at, forKey: "created_at")
        coder.encode(htmlUrl, forKey: "html_url")
    }
}



