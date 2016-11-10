//
//  SettingLauncher.swift
//  youtubeApp
//
//  Created by agenaidy on 11/8/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit


class Setting: NSObject{
    let title: String?
    let IconName: String?
    
    init(title: String , IconName: String){
        self.title = title
        self.IconName = IconName
    }
 
}

class SettingLauncher: NSObject , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let settings: [Setting] = {
        return [Setting(title: "Settings" , IconName: "settings"),
                Setting(title: "Help" , IconName: "help"),
                Setting(title: "Privacy" , IconName: "privacy"),
                Setting(title: "Switch Account" , IconName: "switch_account"),
                Setting(title: "Cancel" , IconName: "cancel")]
    }()
    
    let blackview = UIView()
    
    let collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func showSettings(){
        if let window = UIApplication.shared.keyWindow {
            
            blackview.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackview)
            window.addSubview(collectionview)
            
            let height: CGFloat = CGFloat(self.settings.count*50)
            let y = window.frame.height - height
            collectionview.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: CGFloat(self.settings.count*50))
            
            
            blackview.frame = window.frame
            blackview.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.blackview.alpha = 1
                self.collectionview.frame = CGRect(x: 0, y: y, width: self.collectionview.frame.width, height: self.collectionview.frame.height)
            }, completion: nil)

        }
    }
    
    func handleDismiss(setting: Setting){
        UIView.animate(withDuration: 0.5, delay: 0 , usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackview.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionview.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionview.frame.width, height: self.collectionview.frame.height)
            }
        }) { (completion: Bool) in
            
           if setting.title != "" , setting.title != "Cancel"
           {
            self.homecontroller?.showControllerForSetting(setting: setting)
            }
        }
    }
    var homecontroller:HomeController?
    override init(){
        super.init()
        collectionview.dataSource = self
        collectionview.delegate = self
        
        collectionview.register(SettingLauncherCell.self, forCellWithReuseIdentifier: "SettingCellID")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.settings.count)
        return self.settings.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "SettingCellID", for: indexPath) as! SettingLauncherCell
        cell.iconImage.image = UIImage(named: self.settings[indexPath.row].IconName!)?.withRenderingMode(.alwaysTemplate)
        cell.settinglabl.text = self.settings[indexPath.row].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        handleDismiss(setting: setting)
        }
}

