//
//  FeedCell.swift
//  youtubeApp
//
//  Created by agenaidy on 11/9/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit

class FeedCell:BassCell , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    var videos: [Video]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    func fetchVideo(){
        
        ApiService.sharedInstance.fetchVideoHome { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    
    let CellID = "CellID"
    
    override func setupView() {
        super.setupView()
            self.backgroundColor = .blue
        
        fetchVideo()
        
        addSubview(collectionView)
        addConstrainsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: CellID)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ((frame.width - 16 - 16) * 9 / 16) + 16 + 88
        return CGSize(width: frame.width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }

}
