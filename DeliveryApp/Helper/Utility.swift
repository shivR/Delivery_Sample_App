//
//  Utility.swift
//  DeliveryApp
//
//  Created by Shiv V on 17/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

import UIKit

class Utility: NSObject {
    static let sharedUtility = Utility()
    let cache = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func setImage(with url: String?, _ placeholderImage: UIImage?) {
        if let image = placeholderImage {
            self.image = image
        }
        guard let urlStr = url else {
            return
        }
        if let image = Utility.sharedUtility.cache.object(forKey: urlStr as NSString) {
            self.image = image
            return
        }
        ConnectionManager.instance.downloadImageWithUrl(urlStr, success: {[weak self] (image) in
            guard let strongSelf = self else {
                return
            }
            Utility.sharedUtility.cache.setObject(image, forKey: urlStr as NSString)
            DispatchQueue.main.async {
                strongSelf.image = image
            }
        }) { (error) in
            
        }
    }
}

extension UIView {
    func showIndicator() {
        if self.viewWithTag(1) != nil {
            // Already showing indicator,dismiss
            return
        }
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.color = UIColor.darkGray
        indicator.center = self.center
        indicator.tag = 1
        indicator.startAnimating()
        self.addSubview(indicator)
    }
    
    func stopIndicator() {
        self.viewWithTag(1)?.removeFromSuperview()
    }
}

extension UIViewController {
    func showAlert(_ title: String?, _ message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
