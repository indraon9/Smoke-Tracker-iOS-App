//
//  PacketPurchase.swift
//  SmokeTraker
//
//  Created by Indranil Ghosh on 7/7/19.
//  Copyright © 2019 Apple Tech. All rights reserved.
//

import Foundation
import UIKit


class PacketPurchase: NSObject, NSCoding{
    
    var noOfPacks : Int?
    var purchaseDate : Date?
    var perPackCost : Double?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.noOfPacks, forKey: "noOfPacks")
        aCoder.encode(self.purchaseDate, forKey: "purchaseDate")
        aCoder.encode(self.perPackCost, forKey: "perPackCost")
    }
    
    required init(coder aDecoder: NSCoder) {
        if let noOfPacks = aDecoder.decodeObject(forKey: "noOfPacks") as? Int{
            self.noOfPacks = noOfPacks
        }
        if let purchaseDate = aDecoder.decodeObject(forKey: "purchaseDate") as? Date{
            self.purchaseDate = purchaseDate
        }
        if let perPackCost = aDecoder.decodeObject(forKey: "perPackCost") as? Double{
            self.perPackCost = perPackCost
        }
    }
    
    init(noOfPacks:Int, purchaseDate: Date, perPackCost: Double) {
        self.noOfPacks = noOfPacks
        self.purchaseDate = purchaseDate
        self.perPackCost = perPackCost
    }
}

