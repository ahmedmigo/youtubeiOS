//
//  MenuBar.swift
//  youtubeApp
//
//  Created by agenaidy on 11/6/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    lazy var collectionview: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    var HomeController: HomeController?
    
    let iconsNames = ["home","trending","subscriptions","account"]
    let cellID = "CellID"
    
    var HorizontalBarLeftAnchor: NSLayoutConstraint?
    var selectedIndexPath: NSIndexPath?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionview.register(MenuBarCell.self, forCellWithReuseIdentifier: cellID)
        
        addSubview(collectionview)
        addConstrainsWithFormat(format: "H:|[v0]|", views: collectionview)
        addConstrainsWithFormat(format: "V:|[v0]|", views: collectionview)
        
        SetupHorizontalBar()
        
        selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionview.selectItem(at: selectedIndexPath as? IndexPath, animated: false, scrollPosition: .left)
        
    }
    func SetupHorizontalBar()
    {
        let horizontalbar = UIView()
        horizontalbar.backgroundColor = .white
        horizontalbar.translatesAutoresizingMaskIntoConstraints = false

        addSubview(horizontalbar)
        
        HorizontalBarLeftAnchor = horizontalbar.leftAnchor.constraint(equalTo: self.leftAnchor)
        HorizontalBarLeftAnchor?.isActive = true
        horizontalbar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalbar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalbar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconsNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MenuBarCell
        cell.imageView.image = UIImage(named: iconsNames[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width/CGFloat(self.iconsNames.count)), height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        horizonatalBarAnimation(positionX: CGFloat(indexPath.row))
        HomeController?.scrolltoMenu(MenuIndex: indexPath.row)
        
        selectedIndexPath = NSIndexPath(item: indexPath.row, section: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func horizonatalBarAnimation (positionX: CGFloat)
    {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.HorizontalBarLeftAnchor?.constant = self.frame.width * positionX / 4
            self.layoutIfNeeded()
        }, completion: nil)

    }
}


class MenuBarCell :BassCell{
    let imageView: UIImageView = {
    let iv = UIImageView()
        iv.image = UIImage(named:"home")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? .white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupView() {
        addSubview(imageView)
        addConstrainsWithFormat(format: "V:[v0(28)]", views: imageView)
        addConstrainsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
  }
