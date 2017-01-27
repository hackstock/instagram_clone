//
//  UIDashboardViewController.swift
//  Instagram Clone
//
//  Created by Edward Pie on 26/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import UIKit

class UIDashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let cellId = "FEED_CELL_ID"
    
    let feedsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
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
    
    }
    
    func initializeViews(){
        self.activityIndicator.center = self.view.center
        self.feedsTableView.delegate = self
        self.feedsTableView.dataSource = self
        
        self.feedsTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
    }
    
    func applyLayoutConstraints(){
        self.view.addSubview(self.feedsTableView)
        self.feedsTableView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
