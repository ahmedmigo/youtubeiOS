//
//  ApiService.swift
//  youtubeApp
//
//  Created by agenaidy on 11/9/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchVideoWithURL(target:String, complation: @escaping ([Video])->()){
        let urlString = "\(baseURL)\(target).json"
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    if let unwrappedDate = data, let jsonDictioners = try JSONSerialization.jsonObject(with: unwrappedDate, options: .mutableContainers) as? [[String: AnyObject]] {
                        
                        var videos = [Video]()                        
                        for dictionary in jsonDictioners{
                            let video = Video(dictionary: dictionary)
                            
                            let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                            let channel = Channel()
                            channel.setValuesForKeys(channelDictionary)
                            video.channel = channel
                            
                            videos.append(video)
                        }
                        
                        
//                        let videos = jsonDictioners.map({return Video(dictionary: $0)})
                        DispatchQueue.main.async {
                            complation (videos)
                        }

                                
                    }

                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()    }
    

    func fetchVideoHome(complation: @escaping ([Video])->()){
        fetchVideoWithURL(target: "home", complation: complation)
    }
    func fetchVideoTrending(complation: @escaping ([Video])->()){
        fetchVideoWithURL(target: "trending", complation: complation)
    }
    
    func fetchVideoSubscriptions(complation: @escaping ([Video])->()){
        fetchVideoWithURL(target: "subscriptions" , complation: complation)
    }
}


//for dictionary in json as! [[String: AnyObject]]{
//    let video = Video()
//    video.setValuesForKeys(dictionary)
//    videos.append(video)


