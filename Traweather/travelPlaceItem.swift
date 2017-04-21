//
//  travelPlaceItem.swift
//  Traweather
//
//  Created by Jiayi Zou on 4/20/17.
//  Copyright © 2017 SU. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class travelPlaceItem:NSObject {
    //对任意一个travel place， 我们需要的是：
    //经纬度， 到达时间 离开时间 还需要什么么？
    //var location:CLLocation
    var arriveDate:NSDate
    var leaveDate:NSDate
    var placeMark:MKPlacemark
    init(random:Bool = false) {
        //self.location = CLLocation.init(latitude: 43.052401, longitude: -76.131077)
        self.arriveDate = NSDate()
        self.leaveDate = NSDate()
        self.placeMark = MKPlacemark.init(coordinate: CLLocationCoordinate2D.init(latitude: 43.052401, longitude: -76.131077))
    }
    
    init(location:CLLocation,arriveDate:NSDate,leaveDate:NSDate){
        //self.location = location
        self.arriveDate = arriveDate
        self.leaveDate = leaveDate
        self.placeMark = MKPlacemark.init(coordinate: CLLocationCoordinate2D.init(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
    }
    init(placeMark:MKPlacemark,arriveDate:NSDate,leaveDate:NSDate){
        self.arriveDate = arriveDate;
        self.leaveDate = leaveDate
        self.placeMark = placeMark
    }
    
}
