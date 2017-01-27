//
//  UIImageView.swift
//  Instagram Clone
//
//  Created by Edward Pie on 27/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//
import Foundation
import UIKit

extension UIImageView{
    func loadImageFromUrl(url: URL){
        let sharedSession = URLSession.shared
        
        let queue = DispatchQueue(label: url.absoluteString, qos: .userInteractive)
        queue.async {
            let request = URLRequest(url: url)
            let task = sharedSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if let imageData = data{
                    DispatchQueue.main.async {
                        self.image = UIImage(data: imageData)
                    }
                }
            })
            
            task.resume()
        }
    }
}
