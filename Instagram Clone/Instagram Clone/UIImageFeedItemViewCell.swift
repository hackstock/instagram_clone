//
//  UIImageFeedItemCellView.swift
//  Instagram Clone
//
//  Created by Edward Pie on 27/01/2017.
//  Copyright © 2017 Hubtel. All rights reserved.
//

import UIKit


class UIImageFeedItemCellView: UITableViewCell {
    
    
    let profileInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let profilePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let feedDetailsLabel: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        
        return textView
    }()
    
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
       
        
        
        return imageView
    }()
    
    let likeActionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    
    
    func initializeViews(){
        self.profileInfoView.addSubview(self.profilePictureImageView)
        self.profileInfoView.addSubview(self.feedDetailsLabel)
        self.thumbnailImageView.addSubview(self.likeActionImageView)
        
        self.addSubview(self.profileInfoView)
        self.addSubview(self.thumbnailImageView)
        
        
        
        self.profileInfoView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: thumbnailImageView.topAnchor, right: rightAnchor)
        self.thumbnailImageView.anchorToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        self.thumbnailImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        
        
        self.profilePictureImageView.heightAnchor.constraint(equalTo: profileInfoView.heightAnchor, multiplier: 0.7).isActive = true
        self.profilePictureImageView.centerYAnchor.constraint(equalTo: profileInfoView.centerYAnchor).isActive = true
        self.profilePictureImageView.leftAnchor.constraint(equalTo: profileInfoView.leftAnchor, constant: 8).isActive = true
        self.profilePictureImageView.widthAnchor.constraint(equalTo: profilePictureImageView.heightAnchor).isActive = true
        
        self.feedDetailsLabel.centerYAnchor.constraint(equalTo: profileInfoView.centerYAnchor).isActive = true
        self.feedDetailsLabel.leftAnchor.constraint(equalTo: profilePictureImageView.rightAnchor, constant: 8).isActive = true
        self.feedDetailsLabel.rightAnchor.constraint(equalTo: profileInfoView.rightAnchor, constant: -8).isActive = true
        self.feedDetailsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.likeActionImageView.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor).isActive = true
        self.likeActionImageView.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor).isActive = true
        self.likeActionImageView.heightAnchor.constraint(equalTo: thumbnailImageView.heightAnchor, multiplier: 0.1).isActive = true
        self.likeActionImageView.widthAnchor.constraint(equalTo: likeActionImageView.heightAnchor).isActive = true
        
       
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initializeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
