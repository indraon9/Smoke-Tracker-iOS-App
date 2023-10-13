//
//  PurchaseViewTableController.swift
//  SmokeTraker
//
//  Created by Indranil Ghosh on 6/21/19.
//  Copyright © 2019 Apple Tech. All rights reserved.
//

import Foundation
import os.log

class PurchaseViewTableController{
    public func savePurchase(purchase:Purchase) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(purchase, toFile: Purchase.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Purchase successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save purchase...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadPurchases() -> [Purchase]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Purchase.ArchiveURL.path) as? [Purchase]
    }
}
