//
//  UserDefaultsUtils.swift
//  Astralink
//
//  Created by Asaf Inbar on 05/06/2017.
//  Copyright © 2017 Asaf Inbar. All rights reserved.
//

import UIKit

class UserDefaultsUtils: NSObject {
    var favArray:Array<RepositoryModel> = [RepositoryModel]()
    
    
    static let sharedInstance = UserDefaultsUtils()
    
    override init() {
        super.init()
        //set favorite
        if let data = UserDefaults.standard.data(forKey: "favArray"){
            favArray = (NSKeyedUnarchiver.unarchiveObject(with: data) as? [RepositoryModel])!
        }
    }
    
    func isRepositoryFavorite(repoID:NSNumber) -> Bool {
        if favArray.filter({$0.id == repoID}).first != nil {
            return true
        } else {
            return false
        }

    }
    
    func setFavorite(item:RepositoryModel) {
        if item.isFavorite{
            favArray.append(item)
        }
        else{
            if let i = favArray.index(where: { $0.id == item.id }) {
                favArray.remove(at: i)
            }
        }
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: favArray)
        UserDefaults.standard.set(encodedData, forKey: "favArray")
        UserDefaults.standard.synchronize()
    }
}
