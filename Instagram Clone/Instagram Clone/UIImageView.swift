//
//  UIImageView.swift
//  Instagram Clone
//
//  Created by Edward Pie on 27/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//
import Foundation
import UIKit
import CoreData

extension UIImageView{
    var IMAGE_CACHE_ENTITY_NAME: String{
        get{
            return"CachedImage"
        }
    }
    
    func loadImageFromUrl(url: URL){
        
        if let image = loadImageFromCache(url: url.absoluteString){
            DispatchQueue.main.async {
                self.image = image
            }
            return
        }
        
        
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
    
    func loadImageFromCache(url: String) -> UIImage?{
        var cachedImages: [NSManagedObject] = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: IMAGE_CACHE_ENTITY_NAME)
        
        fetchRequest.predicate = NSPredicate(format: "index == %@", url)
        
        do{
            try cachedImages = managedContext.fetch(fetchRequest)
            return (cachedImages.count > 0) ? UIImage(data: cachedImages[0].value(forKey: "imageData") as! Data) : nil
            
        }catch let error as NSError{
            return nil
        }
    }
}
