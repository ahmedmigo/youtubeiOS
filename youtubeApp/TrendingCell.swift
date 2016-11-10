//
//  TrendingCell.swift
//  youtubeApp
//
//  Created by agenaidy on 11/9/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideo() {
        ApiService.sharedInstance.fetchVideoTrending { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
