//
//  CollectionViewCell.swift
//  PinterestDemo
//
//  Created by Łukasz Jakubek on 28/06/2021.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"
        
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
       return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
        contentView.clipsToBounds = true
        
    }
    
    func configureImage(urlString: String) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        imageView.sd_setImage(with: url)
    }
    
}
