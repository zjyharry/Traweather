//
//  travelPlaceStore.swift
//  Traweather
//
//  Created by Jiayi Zou on 4/20/17.
//  Copyright © 2017 SU. All rights reserved.
//

import Foundation
//this is the store to store travel places.
//TODO:
//1.模仿老师完成这个placestore
//2.写完confirmTravelPlace.swift,目标是可以成功append
class TravelPlaceStore{
    var allTravelPlaceItem = [TravelPlaceItem]()

    
    //creates the allItems array from the data saved in the archive
    init() {
        //NSKeyedUnarchiver returns an Anyobject? initialized from data in the archive, which we downcast to [Item] (since the archive actually stores an [Item] object)
        if let archivedTravelPlaceItems = NSKeyedUnarchiver.unarchiveObject(withFile: travelItemArchiveURL.path) as? [TravelPlaceItem] {
            allTravelPlaceItem += archivedTravelPlaceItems
        }
    }
    
    func update() -> TravelPlaceStore {
        if let archivedTravelPlaceItems = NSKeyedUnarchiver.unarchiveObject(withFile: travelItemArchiveURL.path) as? [TravelPlaceItem] {
            allTravelPlaceItem = archivedTravelPlaceItems
        }
        return self
    }
    
    //itemArchiveURL is the URL of the archive where we will save the allItems array
    let travelItemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("travelItems.archive")
        //return documentDirectory.URLByAppendingPathComponent("items.archive")
    }()
    
    //saveChanges() archives the allItems array to the specified path
    func saveChanges() -> Bool {
        print("Saving allItems to: \(travelItemArchiveURL.path)")
        
        //archiveRootObject() creates an instance of NSKeyedArchiver (which is a sub-class of NSCoder)
        //and calls encodeWithCoder() on the root object (the allItems array),
        //which RECURSIVELY calls encodeWithCoder() on all of its sub-objects
        //to save all the items inside the same instance of the NSKeyedArchiver
        return NSKeyedArchiver.archiveRootObject(allTravelPlaceItem, toFile: travelItemArchiveURL.path)
    }
    
    //clear all the data we saved in the path
    func clearAllChanges() -> Bool {
        print("Clearing All Items")
        //考虑加个警告？
        return NSKeyedArchiver.archiveRootObject([TravelPlaceItem](), toFile: travelItemArchiveURL.path)
    }
    
    //creates an item, inserts it in the array, and returns the created item
    func createItem() -> TravelPlaceItem {
        let item = TravelPlaceItem(random: false)
        allTravelPlaceItem.append(item)
        //allItems.insert(item, atIndex: 0)
        return item
    }
    
    //add an real item
    
    func addItem(item:TravelPlaceItem) -> TravelPlaceItem {
        allTravelPlaceItem.append(item)
        //allItems.insert(item, atIndex: 0)
        return item
    }
    
    //removes a specified item from the array
    func removeItem(item: TravelPlaceItem) {
        if let index = allTravelPlaceItem.index(of: item) {
            allTravelPlaceItem.remove(at: index)
        }
    }
    
    //reorders an item in the array from "fromIndex" to "toIndex"
    func moveItemFromIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let item = allTravelPlaceItem[fromIndex]
        
        allTravelPlaceItem.remove(at: fromIndex)
        
        allTravelPlaceItem.insert(item, at: toIndex)
    }
    
    //function to print all items in the array
    func printAllItems() {
        for item in allTravelPlaceItem {
            print("arrive date is \(item.arriveDate), leave date is \(item.leaveDate), and the city is \(item.placeMark.locality ?? "no city") , and the state is \(item.placeMark.administrativeArea ?? "no state")")
        }
    }
}
