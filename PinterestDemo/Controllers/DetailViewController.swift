//
//  DetailViewController.swift
//  PinterestDemo
//
//  Created by Łukasz Jakubek on 05/07/2021.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    //MARK: Property
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .close)
        button.tintColor = .red
        return button
    }()
    
    
    
    
//MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    @objc func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureImage(urlString: String) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        imageView.sd_setImage(with: url)
    }
    

}
