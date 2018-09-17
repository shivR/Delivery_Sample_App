//
//  DeliveryDetailTableViewController.swift
//  DeliveryApp
//
//  Created by Shiv V on 17/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

import UIKit

class DeliveryDetailTableViewController: UITableViewController {
    var delivery: Delivery? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Delivery Details"
        
        self.tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(MapTableViewCell.self, forCellReuseIdentifier: "mapcell")
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
        
    }
}

extension DeliveryDetailTableViewController {
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Show Map
            let cell = tableView.dequeueReusableCell(withIdentifier: "mapcell", for: indexPath) as! MapTableViewCell
            cell.selectionStyle = .none
            if let deliveryDetail = self.delivery {
                cell.updateViewWithInfo(deliveryDetail)
            }
            return cell
            
        } else {
            // Show details
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryTableViewCell
            cell.selectionStyle = .none
            if let deliveryDetail = self.delivery {
                cell.updateViewWithInfo(deliveryDetail)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // Map
            return (UIScreen.main.bounds.height - UIScreen.main.bounds.height/3)
        }
        return 126
    }
}
