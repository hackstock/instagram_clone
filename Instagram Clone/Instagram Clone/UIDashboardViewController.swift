//
//  UIDashboardViewController.swift
//  Instagram Clone
//
//  Created by Edward Pie on 26/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import UIKit

class UIDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchResultsUpdating, UISearchBarDelegate{
    let cellId = "FEED_CELL_ID"
    let sharedSession = URLSession.shared
    
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
        self.fetchFeedsFromInstagram()
    
    }
    
    func initializeViews(){
        self.title = "Instagram"
        
        self.activityIndicator.center = self.view.center
        self.feedsTableView.delegate = self
        self.feedsTableView.dataSource = self
        
        self.searchViewController.searchBar.delegate = self
        self.searchViewController.searchResultsUpdater = self
        
        self.feedsTableView.tableHeaderView = self.searchViewController.searchBar
        
        self.feedsTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
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
    
    func fetchFeedsFromInstagram(){
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
                    
                    let metaDataObject = json["meta"] as? [String: Any]
                    let metaDataInfo = ResponseMetaData.fromJson(json: metaDataObject!)
                    
                    print("META : \(metaDataInfo)")
                }catch{
                    print("ERROR : \(error.localizedDescription)")
                    return
                }
            })
            
            dataTask.resume()
            self.showActivityIndicator()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as UITableViewCell
        return cell
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
    

}
