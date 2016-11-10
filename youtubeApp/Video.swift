//
//  Video.swift
//  youtubeApp
//
//  Created by agenaidy on 11/7/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit


class Video: NSObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
//        if key == "channel" {
//            
//            let channelDictionary = value as! [String: AnyObject]
//            let channel = Channel()
//            channel.setValuesForKeys(channelDictionary)
//            self.channel = channel
//        }
        super.setValue(value, forKey: key)
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

class Channel: NSObject {
    var name: String?
    var profile_image_name: String?
}
