//
//  NetworkManager.swift
//  Astralink
//
//  Created by Asaf Inbar on 29/05/2017.
//  Copyright © 2017 Asaf Inbar. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    
    init() {
    }


    func getRepositoryList(listType:NSInteger,
                           pageCount:NSInteger,
                           completionHandler:@escaping (Array<RepositoryModel>, Error?)->Void) {
        
        var repoArray:Array<RepositoryModel> = Array()
        
        Alamofire.request("https://api.github.com/search/repositories",
                          method: .get,
                          parameters: getParams(listType: listType, pageCount: pageCount),
                          encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String:Any]
                        if let items = parsedData["items"] as? NSArray {
                            for item in items {
                                let repoModel = RepositoryModel.init(item: item as? NSDictionary)
                                repoArray.append(repoModel)
                            }
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                    
                    completionHandler(repoArray, nil)
                }
                break
                
            case .failure(_):
                completionHandler([], response.result.error)
                print(response.result.error ?? "Error")
                break
                
            }
        }
    }
    
    func getParams(listType:NSInteger,
                   pageCount:NSInteger) -> Dictionary<String, String>? {
        
        let calendar = Calendar.current
        var startDate:Date = NSDate() as Date
        
        switch listType {
        case 0:
            startDate = calendar.date(byAdding: .day, value: -1, to: Date())!
            break
        case 1:
            startDate = calendar.date(byAdding: .day, value: -7, to: Date())!
            break
        case 2:
            startDate = calendar.date(byAdding: .month, value: -1, to: Date())!
            break
        default:
            startDate = NSDate() as Date
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from:startDate)

        
        let paramDic:Dictionary = ["q":"created:>\(dateString)", "sort":"stars", "order":"desc", "page":(pageCount as NSNumber).stringValue]
        return paramDic
        
    }


}
