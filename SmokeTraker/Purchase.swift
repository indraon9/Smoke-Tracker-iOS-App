//
//  Purchase.swift
//  SmokeTraker
//
//  Created by Indranil Ghosh on 6/21/19.
//  Copyright © 2019 Apple Tech. All rights reserved.
//

import Foundation
import os.log

class Purchase: NSObject, NSCoding {
    //MARK: Properties
    var purchaseDate:Date
    var noOfPacks:NSInteger
    var totalCost:Double
    struct PropertyKey{
        static let purchaseDate = "purchaseDate"
        static let noOfPacks = "noOfPacks"
        static let totalCost = "totalCost"
    }
    
    //MARK: Initialization
    init?(purchaseDate:Date, noOfPacks:NSInteger, totalCost:Double) {
        self.purchaseDate=purchaseDate
        self.noOfPacks=noOfPacks
        self.totalCost=totalCost
    }
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(purchaseDate, forKey: PropertyKey.purchaseDate)
        aCoder.encode(noOfPacks, forKey: PropertyKey.noOfPacks)
        aCoder.encode(totalCost, forKey: PropertyKey.totalCost)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let purchaseDate = aDecoder.decodeObject(forKey: PropertyKey.purchaseDate) as? Date else {
            os_log("Unable to decode the purchaseDate", log: OSLog.default, type: .debug)
            return nil
        }
        guard let noOfPacks = aDecoder.decodeObject(forKey: PropertyKey.noOfPacks) as? NSInteger else {
            os_log("Unable to decode the noOfPacks", log: OSLog.default, type: .debug)
            return nil
        }
        guard let totalCost = aDecoder.decodeObject(forKey: PropertyKey.totalCost) as? Double else {
            os_log("Unable to decode the totalCost", log: OSLog.default, type: .debug)
            return nil
        }

        self.init(purchaseDate: purchaseDate, noOfPacks: noOfPacks, totalCost: totalCost)
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("PurchaseHistory")
}
