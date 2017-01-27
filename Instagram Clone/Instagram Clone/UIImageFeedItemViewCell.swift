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
        
        return view
    }()
    
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    
    
    func initializeViews(){
        self.addSubview(self.profileInfoView)
        self.addSubview(self.thumbnailImageView)
        
        
        self.profileInfoView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: thumbnailImageView.topAnchor, right: rightAnchor)
        self.thumbnailImageView.anchorToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        self.thumbnailImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
       
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
