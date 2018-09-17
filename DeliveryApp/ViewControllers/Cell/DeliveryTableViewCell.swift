//
//  DeliveryTableViewCell.swift
//  DeliveryApp
//
//  Created by Shiv V on 17/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {

    var bgView: UIView = UIView()
    var deliveryImageView: UIImageView = UIImageView()
    var titleLabel: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        self.bgView.frame = CGRect(x: 16, y: 8, width: UIScreen.main.bounds.width - 32, height: 110)
        self.bgView.layer.cornerRadius = 5.0
        self.bgView.layer.borderColor = UIColor.lightGray.cgColor
        self.bgView.layer.borderWidth = 1.0
        self.bgView.layer.masksToBounds = true
        self.contentView.addSubview(self.bgView)
        
        self.deliveryImageView.frame = CGRect(x: 8, y: 8, width: 94, height: 94)
        self.deliveryImageView.layer.cornerRadius = 47.0
        self.deliveryImageView.contentMode = .scaleAspectFill
        self.deliveryImageView.layer.masksToBounds = true
        self.bgView.addSubview(self.deliveryImageView)
        
        self.titleLabel.frame = CGRect(x: 110, y: 8, width: UIScreen.main.bounds.width-142, height: 94)
        self.titleLabel.numberOfLines = 0
        self.bgView.addSubview(self.titleLabel)
    }
    
    func updateViewWithInfo(_ delivery: Delivery) {
        let location = delivery.location?.anyObject() as? Location // will always return 1
        self.titleLabel.text = (delivery.deliveryDescription ?? "") + " at " + (location?.address ?? "")
        self.deliveryImageView.setImage(with: delivery.imageUrl, UIImage(named: "delivery"))
    }
}
