//
//  Header.swift
//  PinterestDemo
//
//  Created by Łukasz Jakubek on 06/07/2021.
//

import UIKit

class Header: UICollectionReusableView {
    
    static let indentifier: String = "Header"
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Photo Search"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        label.textColor = .blue
       return label
    }()
    
    func configureHeader() {
        addSubview(label)
        label.frame = bounds
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
        
    }
    
}
