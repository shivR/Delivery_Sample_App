//
//  DeliveryViewController.swift
//  DeliveryApp
//
//  Created by Shiv V on 17/09/18.
//  Copyright © 2018 Freebie. All rights reserved.
//

import UIKit
import CoreData

class DeliveryViewController: UITableViewController {

    var deliveriesArray: [Delivery] = []
    var pageOffset = -1
    var pageLimit = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Thing to Deliver"
        
        self.tableView.register(DeliveryTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fetch offline deliveries from DB
        self.fetchOfflineDeliveries()
        
        // Calculate the page offset
        self.pageOffset = self.deliveriesArray.count/self.pageLimit
        
        // If offset is 0, call the api, other wise we will call api on last index of tableview
        if pageOffset == 0 {
            self.fetchDeliveries()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.window?.stopIndicator()
    }
    
    func fetchOfflineDeliveries() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Delivery")
        let context = AppDelegate.appDelegate.persistentContainer.viewContext
        do {
            if let result = try context.fetch(request) as? [Delivery] {
                self.deliveriesArray.append(contentsOf: result)
            }
            self.tableView.reloadData()
        } catch {
            print("Failed to get deliveries from Database")
        }
    }
    
    // Fetch from API
    func fetchDeliveries() {
        self.view.window?.showIndicator()
        self.pageOffset += 1
        DeliveryManager.instance.fetchDeliveries(offset: self.pageOffset, limit: self.pageLimit, success: {[weak self] (deliveries) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.deliveriesArray.append(contentsOf: deliveries)
            
            DispatchQueue.main.async {
                strongSelf.view.window?.stopIndicator()
                strongSelf.tableView.reloadData()
            }
        }) {[weak self] (error) in
            guard let strongSelf = self else {
                return
            }
            DispatchQueue.main.async {
                strongSelf.view.window?.stopIndicator()
                strongSelf.showAlert("Error", error?.localizedDescription ?? "Failed to get deliveries")
            }
        }
    }
}

extension DeliveryViewController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliveriesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryTableViewCell
        cell.selectionStyle = .none
        
        let delivery = self.deliveriesArray[indexPath.row]
        cell.updateViewWithInfo(delivery)
        
        // If user scrolled to last index, call API
        let lastItem = (delivery.deliveryId == self.deliveriesArray.last?.deliveryId)
        if lastItem && indexPath.row == self.deliveriesArray.count-1 {
            self.fetchDeliveries()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DeliveryDetailTableViewController()
        detailVC.delivery = self.deliveriesArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
