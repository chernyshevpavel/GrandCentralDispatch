//
//  SecondViewController.swift
//  GCD
//
//  Created by Павел Чернышев on 22.09.2020.
//  Copyright © 2020 Павел Чернышев. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imageVIew?.image
        }
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageVIew?.image = newValue
            imageVIew?.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    fileprivate func fetchImage() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        imageURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")
        guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
        self.image = UIImage(data: imageData)

    }
    
}
