//
//  UILoginViewController.swift
//  Instagram Clone
//
//  Created by Edward Pie on 26/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import UIKit

class UILoginViewController: UIViewController, UIWebViewDelegate {
    
    var activityIndicator: UIActivityIndicatorView!
    var hasFinishedAuthorization = false
    
    let webView: UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
    
        
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeViews()
        self.applyLayoutConstraints()
        self.loadInstagramLoginPage()
    }
    
    func initializeViews(){
        self.webView.delegate = self
        
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = .gray
    }
    
    func applyLayoutConstraints(){
        self.view.addSubview(self.webView)
        
        self.webView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func loadInstagramLoginPage(){
        let clientId = AppConfig.TargetApiEnvironment.getEnvironmentConfiguration().clientID
        let redirectUrl = AppConfig.TargetApiEnvironment.getEnvironmentConfiguration().redirectUrl
        
        let authenticationUrl = "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectUrl)&response_type=token"
        self.webView.loadRequest(URLRequest(url: URL(string: authenticationUrl)!))
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let urlString = request.url?.absoluteString
        var urlComponents = urlString?.components(separatedBy: "#")
        if (urlComponents?.count)! > 1{
            self.hasFinishedAuthorization = true
            let accessToken = urlComponents?[1].components(separatedBy: "=")[1]
            AppConfig.storeAccessToken(token: accessToken!)
        }
        
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        if(self.hasFinishedAuthorization){
            self.present(UIDashboardViewController(), animated: true, completion: nil)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
