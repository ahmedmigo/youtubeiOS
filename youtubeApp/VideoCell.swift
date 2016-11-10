//
//  VideoCell.swift
//  youtubeApp
//
//  Created by agenaidy on 11/6/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit

class BassCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView()
    {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BassCell{
    
    
    var video: Video? {
        didSet {
            titlelbl.text = video?.title
            
            setupThumbNailImage()
            
            setupProfileImage()
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 years ago "
                datalbl.text = subtitleText
            }
            
            //measure title text
            if let title = video?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16,height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
            
        }
    }
    
    func setupProfileImage(){
        if let profileImageURL = video?.channel?.profile_image_name {
            print(profileImageURL)
            profileThumb.loadImageUsingURLString(urlString: profileImageURL)
        }
    }
    
    func setupThumbNailImage(){
        if let thumbnailImageURL = video?.thumbnail_image_name {
            videoThumbnail.loadImageUsingURLString(urlString: thumbnailImageURL)
        }
    }
    
    let videoThumbnail: CustomUIImageView = {
        let imageView = CustomUIImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let sparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let profileThumb: CustomUIImageView = {
        let view = CustomUIImageView()
        view.image = UIImage(named: "taylor_swift_profile")
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        return view
    }()
    
    let titlelbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let datalbl : UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TaylorSwiftVEVO • 1,600,844,234 views  •  2 years ago"
        label.textColor = .gray
        label.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return label
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupView()
    {
        //subviewSetups
        addSubview(videoThumbnail)
        addSubview(sparator)
        addSubview(profileThumb)
        addSubview(titlelbl)
        addSubview(datalbl)
        
        //constrains
        //Horizontal Constrains
        addConstrainsWithFormat(format: "H:|-16-[v0]-16-|", views: videoThumbnail)
        addConstrainsWithFormat(format: "H:|[v0]|", views: sparator)
        addConstrainsWithFormat(format: "H:|-16-[v0(44)]", views: profileThumb)
        
        //Vertical Constrains
        addConstrainsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: videoThumbnail,profileThumb,sparator)
        
        //Top Constraint
        addConstraint(NSLayoutConstraint(item: titlelbl, attribute: .top, relatedBy: .equal, toItem: videoThumbnail, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: datalbl, attribute: .top, relatedBy: .equal, toItem: titlelbl, attribute: .bottom, multiplier: 1, constant: 4))
        
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: titlelbl, attribute: .left, relatedBy: .equal, toItem: profileThumb, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: datalbl, attribute: .left, relatedBy: .equal, toItem: profileThumb, attribute: .right, multiplier: 1, constant: 8))
        
        //right Constraint
        addConstraint(NSLayoutConstraint(item: titlelbl, attribute: .right, relatedBy: .equal, toItem: videoThumbnail, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: datalbl, attribute: .right, relatedBy: .equal, toItem: videoThumbnail, attribute: .right, multiplier: 1, constant: 0))
        
        //Hight Constraint
        addConstraint(NSLayoutConstraint(item: datalbl, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titlelbl, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
        
    }

}
