//
//  UIDashboardViewController.swift
//  Instagram Clone
//
//  Created by Edward Pie on 26/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import UIKit
import CoreData
import SystemConfiguration

class UIDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchResultsUpdating, UISearchBarDelegate{
    let cellId = "FEED_CELL_ID"
    let FEED_ITEMS_ENTITY_NAME = "FeedItem"
    
    
    let sharedSession = URLSession.shared
    var feedItems = [NSManagedObject]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(UIDashboardViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    let feedsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let searchViewController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.sizeToFit()
        
        
        return searchController
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.activityIndicatorViewStyle = .gray
        
        return activityIndicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeViews()
        self.applyLayoutConstraints()

        if AppConfig.hasStoredFeedsOffline() != nil{
            if self.fetchFeedsFromStorage(){
                self.feedsTableView.reloadData()
                
            }else{
                self.fetchFeedsFromInstagram()
            }
        }else{
            self.fetchFeedsFromInstagram()
        }
        
    }
    
    func initializeViews(){
        self.title = "Instagram"
        
        self.activityIndicator.center = self.view.center
        
        self.feedsTableView.delegate = self
        self.feedsTableView.dataSource = self
        self.feedsTableView.separatorStyle = .none
        self.feedsTableView.allowsSelection = false
        self.feedsTableView.addSubview(self.refreshControl)
        
        
        self.searchViewController.searchBar.delegate = self
        self.searchViewController.searchResultsUpdater = self
        
        self.feedsTableView.tableHeaderView = self.searchViewController.searchBar
        
        self.feedsTableView.register(UIImageFeedItemCellView.self, forCellReuseIdentifier: self.cellId)
    }
    
    func applyLayoutConstraints(){
        self.view.addSubview(self.feedsTableView)
        self.feedsTableView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func showActivityIndicator(){
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator(){
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        let queue = DispatchQueue(label: "", qos: .userInitiated)
        queue.sync {
            self.fetchFeedsFromInstagram()
        }
        
        self.refreshControl.endRefreshing()
    }
    
    func fetchFeedsFromInstagram(){
        
        self.deleteStoredFeedItems()
        
        let baseUrl = AppConfig.TargetApiEnvironment.getEnvironmentConfiguration().baseUrl
        let accessToken = AppConfig.getAccessToken()
        
        if let url = URL(string: "\(baseUrl)/users/self/media/recent?access_token=\(accessToken!)"){
            let request = URLRequest(url: url)
            let dataTask = self.sharedSession.dataTask(with: request, completionHandler: { (data, response, error) in
                self.stopActivityIndicator()
                do{
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else{
                        return
                    }
                    
                    let dataObject = json["data"] as? [Any]
                    
                    var serializedFeedItem: FeedItem!
                    var savedFeedItem: NSManagedObject!
                    
                    for jsonNode in dataObject!{
                        serializedFeedItem = FeedItem.fromJson(json: jsonNode as! [String : Any])
                        savedFeedItem = self.saveForOfflineAccess(instagramFeed: serializedFeedItem)
                        self.feedItems.append(savedFeedItem)
                        
                    }
                    
                    AppConfig.setHasStoredFeedsOffline(status: true)
                    self.feedsTableView.reloadData()
                    
                }catch{
                    AppConfig.setHasStoredFeedsOffline(status: false)
                    return
                }
            })
            
            self.showActivityIndicator()
            dataTask.resume()
            
        }
    }
    
    func fetchFeedsFromStorage() -> Bool{
        guard let appDelete = UIApplication.shared.delegate as? AppDelegate else{
            return false
        }
        
        let managedContext = appDelete.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: FEED_ITEMS_ENTITY_NAME)
        
        do{
            try self.feedItems = managedContext.fetch(fetchRequest)
            return true
        }catch let error as NSError{
            print("ERROR FETCHING FEEDS : \(error.localizedDescription)")
            return false
        }
    }
    
    func deleteStoredFeedItems(){
        self.feedItems = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: FEED_ITEMS_ENTITY_NAME)
        
        do{
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try managedContext.execute(batchDeleteRequest)
            
        }catch let error as NSError{
            print("ERROR DELETING FEEDS : \(error.localizedDescription)")
        }
    }
    
    func saveForOfflineAccess(instagramFeed: FeedItem) -> NSManagedObject?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let feedItemEntity = NSEntityDescription.entity(forEntityName: FEED_ITEMS_ENTITY_NAME, in: managedContext)
        let feedItem = NSManagedObject(entity: feedItemEntity!, insertInto: managedContext)
        
        feedItem.setValue(instagramFeed.id, forKey: "index")
        feedItem.setValue(instagramFeed.type, forKey: "type")
        feedItem.setValue(instagramFeed.isLikedByUser, forKey: "isLikedByUser")
        feedItem.setValue(instagramFeed.comments, forKey: "comments")
        feedItem.setValue(instagramFeed.likes, forKey: "likes")
        feedItem.setValue(instagramFeed.caption, forKey: "caption")
        feedItem.setValue(instagramFeed.thumbnailUrl, forKey: "thumbnailUrl")
        feedItem.setValue(instagramFeed.mediaUrl, forKey: "mediaUrl")
        feedItem.setValue(instagramFeed.user.username, forKey: "username")
        feedItem.setValue(instagramFeed.user.avatarUrl, forKey: "userAvatarUrl")
        
        
        do{
            try managedContext.save()
            return feedItem
        }catch let error as NSError{
            print("ERROR SAVING FEED : \(error.localizedDescription)")
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedItem = self.feedItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! UIImageFeedItemCellView
        cell.thumbnailImageView.loadImageFromUrl(url: URL(string: (feedItem.value(forKey: "thumbnailUrl") as? String)!)!)
        cell.profilePictureImageView.loadImageFromUrl(url: URL(string: (feedItem.value(forKey: "userAvatarUrl") as? String)!)!)
        
        
        
        let feedDetailsText = NSMutableAttributedString(string: (feedItem.value(forKey: "username") as? String)!, attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold),
            NSForegroundColorAttributeName: UIColor(hexString: "#055FA1FF")
            ])
        
        feedDetailsText.append(NSMutableAttributedString(string: "  \((feedItem.value(forKey: "caption") as? String)!)", attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium),
            NSForegroundColorAttributeName: UIColor(white: 0.5, alpha: 1)
            ]))
        
        feedDetailsText.append(NSMutableAttributedString(string: "\n\((feedItem.value(forKey: "likes") as? Int)!) Likes", attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium),
            NSForegroundColorAttributeName: UIColor(white: 0.2, alpha: 1)
            ]))
        
        feedDetailsText.append(NSMutableAttributedString(string: "    \((feedItem.value(forKey: "comments") as? Int)!) Comments", attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium),
            NSForegroundColorAttributeName: UIColor(white: 0.2, alpha: 1)
            ]))
        
        
        cell.feedDetailsLabel.attributedText = feedDetailsText
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isInternetConnectionAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    

}
