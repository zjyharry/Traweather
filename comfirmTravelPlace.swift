//
//  comfirmTravelPlace.swift
//  Traweather
//
//  Created by Jiayi Zou on 4/20/17.
//  Copyright © 2017 SU. All rights reserved.
//

import UIKit
import MapKit
class confirmTravelPlace : UIViewController{
    
    var place:MKPlacemark?
    var travelPlaceStore:TravelPlaceStore?
    let txt = "txt"

    @IBOutlet weak var TitleLable: UILabel!
    @IBOutlet weak var ChoiceLabel: UILabel!

    @IBOutlet weak var arriveDateLabel: UILabel!
    
    @IBOutlet weak var leaveDateLabel: UILabel!
    
    @IBOutlet weak var arriveDatePicker: UIDatePicker!
    
    @IBOutlet weak var leaveDatePicker: UIDatePicker!

    @IBOutlet weak var comfirmButton: UIButton!
    
    @IBOutlet weak var previewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.locale=NSLocale.current
        if travelPlaceStore==nil {
            travelPlaceStore=TravelPlaceStore.init()
        }else{
            travelPlaceStore=travelPlaceStore?.update()
        }
        leaveDatePicker.date = NSCalendar.current.date(byAdding: Calendar.Component.day, value: 1, to: NSDate() as Date, wrappingComponents: false)!
        ChoiceLabel.text = "\(place?.locality ?? "no city") , \(place?.administrativeArea ?? "no state")"
    }

    @IBAction func previewButtonPressed(_ sender: UIButton) {
        travelPlaceStore = travelPlaceStore?.update()
        travelPlaceStore?.printAllItems()
    }

    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        travelPlaceStore?.addItem(item: TravelPlaceItem.init(placeMark: place!, arriveDate: arriveDatePicker.date as NSDate, leaveDate: leaveDatePicker.date as NSDate))
        travelPlaceStore?.saveChanges()
    }

    
}

