//
//  travelPlaceView.swift
//  Traweather
//
//  Created by Jiayi Zou on 4/22/17.
//  Copyright © 2017 SU. All rights reserved.
//

import Foundation
import UIKit

class TravelPlaceView: UITableViewController {
    
    var travelPlaceStore:TravelPlaceStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if travelPlaceStore==nil {
            travelPlaceStore=TravelPlaceStore.init()
        }else{
            travelPlaceStore=travelPlaceStore.update()
        }
        
        //set contentInset for tableView
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        
        tableView.estimatedRowHeight = 100
        
        navigationItem.title = "Your Travel Plan"
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        travelPlaceStore = travelPlaceStore.update()
        tableView.reloadData()
    }
    //jump to map view
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mapview = sb.instantiateViewController(withIdentifier: "TabBarView")
        self.present(mapview, animated: true, completion: nil)
        
        print("pressed")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print(#function)
        
        if editingStyle == .delete {
            let item = travelPlaceStore.allTravelPlaceItem[indexPath.row]
            
            let title = "Delete \(String(describing: item.placeMark.locality))?"
            let message = "Are you sure?"
            
            //UIAlertController
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            //Cancel Action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            //Delete Action
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(delete) -> Void in
                //deletes the item from the array
                self.travelPlaceStore.removeItem(item: item)
                
                //deletes the row in the tableView the user wants to delete
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection \(section): \(travelPlaceStore.allTravelPlaceItem.count)")
        return travelPlaceStore.allTravelPlaceItem.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 5
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = travelPlaceStore.allTravelPlaceItem[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelPlaceCell", for: indexPath) as! TravelPlaceCell
        cell.arriveCityLabel.text = item.placeMark.locality
        cell.leaveCityLabel.text = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        cell.arriveDateLabel.text = dateFormatter.string(from: item.arriveDate as Date)
        cell.leaveDateLabel.text = dateFormatter.string(from: item.leaveDate as Date)
        cell.updateLabels()
        cell.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 5
        return cell
    }

}
