//
//  SettingCell.swift
//  youtubeApp
//
//  Created by agenaidy on 11/8/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit

class SettingLauncherCell: BassCell {
    
    let iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .gray
        
        return image
    }()
    let settinglabl: UILabel = {
        let labl = UILabel()
        labl.text = "Setting"
        labl.font = UIFont.systemFont(ofSize: 13)
        labl.textColor = .gray
        return labl
    }()
    
    override var isHighlighted: Bool{
        didSet{
            self.backgroundColor = isHighlighted ? .gray : .white
            settinglabl.textColor = isHighlighted ? .white : .gray
            iconImage.tintColor = isHighlighted ? .white : .gray
        }
    }
    override func setupView() {
        addSubview(iconImage)
        addSubview(settinglabl)
        
        addConstrainsWithFormat(format: "H:|-8-[v0(20)]-8-[v1]-8-|", views: iconImage,settinglabl)
        addConstrainsWithFormat(format: "V:[v0(20)]", views: iconImage)
        addConstraint(NSLayoutConstraint(item: settinglabl, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    
}
