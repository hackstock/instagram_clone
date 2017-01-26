//
//  UILoginViewController.swift
//  Instagram Clone
//
//  Created by Edward Pie on 26/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import UIKit

class UILoginViewController: UIViewController, UIWebViewDelegate {
    
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
    }
    
    func applyLayoutConstraints(){
        self.view.addSubview(self.webView)
        
        self.webView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func loadInstagramLoginPage(){
        let clientId = AppConfig.TargetApiEnvironment.getEnvironmentConfiguration().clientID
        let redirectUrl = AppConfig.TargetApiEnvironment.getEnvironmentConfiguration().redirectUrl
        
        let authenticationUrl = "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectUrl)&response_type=token"
        self.webView.loadRequest(URLRequest(url: URL(string: authenticationUrl)!))
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        var urlString = request.url?.absoluteString
        print("URL STRING : \(urlString)")
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
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
