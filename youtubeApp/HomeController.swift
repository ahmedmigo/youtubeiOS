//
//  ViewController.swift
//  youtubeApp
//
//  Created by agenaidy on 11/6/16.
//  Copyright © 2016 agenaidy. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

//    var videos: [Video] = {
//        var kanyeChannel = Channel()
//        kanyeChannel.name = "KanyeIsTheBestChannel"
//        kanyeChannel.profileImageName = "kanye_profile"
//        
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - Blank Space"
//        blankSpaceVideo.thumbnailImageName = "taylor_swift_blank_varce"
//        blankSpaceVideo.channel = kanyeChannel
//        blankSpaceVideo.numberOfViews = 23932843093
//        
//        var badBloodVideo = Video()
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.thumbnailImageName = "taylor_swift_bad_blood"
//        badBloodVideo.channel = kanyeChannel
//        badBloodVideo.numberOfViews = 57989654934
//        
//        return [blankSpaceVideo, badBloodVideo]
//    }()
    
    let feedID : String = "FeedID"
    let trendindCellID: String = "trendingCellID"
    let subscriptiansCellID: String = "SubscriptionCellID"
    let ProfileCellID: String = "ProifleCellID"
    let titles = ["Home","Trending","Subscriptions","Profile"]
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLable.textColor = .white
        titleLable.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLable
        setNavbarTitle(index: 0)
        

        setupCollectionView()
        setupMenuBar ()
        setupNavBarIcons()
        
    }
    

    
    func setupCollectionView(){
        
        if let flowlayout = collectionView?.collectionViewLayout as?
            UICollectionViewFlowLayout{
        flowlayout.scrollDirection = .horizontal
        flowlayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = .white
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "CellID")
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: feedID)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendindCellID)
        collectionView?.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptiansCellID)
        collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCellID)
        collectionView?.contentInset = UIEdgeInsetsMake(50,0,0,0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50,0,0,0)
        collectionView?.isPagingEnabled = true
    
    }
    
    func setupNavBarIcons(){
        let searchIcon = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarIcon = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(handleSearch))
        let navMoreIcon = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMoreIcon))
        navigationItem.rightBarButtonItems = [navMoreIcon,searchBarIcon]
    }

    lazy var settingLauncher: SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homecontroller = self
        return launcher
    }()
    
    func handleMoreIcon(){
        settingLauncher.showSettings()
    }
    
    func showControllerForSetting(setting :Setting) {
        let dummySetting = UIViewController()
        dummySetting.view.backgroundColor = .white
        dummySetting.navigationItem.title = setting.title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.pushViewController(dummySetting, animated: true)
    }
    
    func handleSearch(){
        print("search")
    }
    
    func scrolltoMenu(MenuIndex: Int){
        let indexPath = IndexPath(item: MenuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        setNavbarTitle(index: MenuIndex)
    }
    
    private func setNavbarTitle (index: Int){
        if let titlelbal = navigationItem.titleView as? UILabel{
            titlelbal.text = "   \(titles[index])"
        }
    }
    
    lazy var menubar: MenuBar = {
       let mb = MenuBar()
       mb.HomeController = self
    return mb
    }()
    private func setupMenuBar (){
        
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        
        view.addSubview(redView)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstrainsWithFormat(format: "V:|[v0(50)]", views: redView)
        
        view.addSubview(menubar)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: menubar)
        view.addConstrainsWithFormat(format: "V:[v0(50)]", views: menubar)

        menubar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menubar.HorizontalBarLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }
    

    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let position = targetContentOffset.pointee.x / view.frame.width
        print(position)
        let indexpath = IndexPath(row: Int(position), section: 0)
        menubar.collectionview.selectItem(at: indexpath, animated: true, scrollPosition: .centeredHorizontally)
        
        setNavbarTitle(index: Int(position))
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String?
        if indexPath.item == 1 {
            identifier = trendindCellID
        } else if indexPath.item == 2 {
             identifier = subscriptiansCellID
        } else if indexPath.item == 3 {
            identifier = ProfileCellID
        }else {
            identifier = feedID
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier!, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

}





