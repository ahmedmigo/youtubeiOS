//
//  SubscriptionCell.swift
//  youtubeApp
//
//  Created by agenaidy on 11/9/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideo() {
        ApiService.sharedInstance.fetchVideoSubscriptions { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
