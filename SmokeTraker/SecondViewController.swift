//
//  SecondViewController.swift
//  SmokeTraker
//
//  Created by Indranil Ghosh on 6/16/19.
//  Copyright © 2019 Apple Tech. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let packData = UserDefaults.standard
    var rowCount = 0
    var purchaseReport: [PacketPurchase] = []
    @IBOutlet var populateTableView: UITableView!
    let formatter = DateFormatter()
    
    override func viewWillAppear(_ animated: Bool) {
        debugPrint("viewWillAppear is called...")
        super.viewWillAppear(animated)
        let storedData = packData.data(forKey: "packData")
        if storedData != nil{
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            do{
                purchaseReport = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData!) as? [PacketPurchase])!
                //debugPrint(purchaseReport.debugDescription)
                debugPrint("Number of report available in UserData : " + String(purchaseReport.count))
                rowCount = purchaseReport.count + 1
            }catch{
                fatalError("Error occured while fetching purchase report array")
            }
        }else{
        }
        populateTableView.reloadData()
    }
    
    override func viewDidLoad() {
        debugPrint("viewDidLoad is called...")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        populateTableView.dataSource = self
        populateTableView.delegate = self
        let storedData = packData.data(forKey: "packData")
        if storedData != nil{
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            do{
                purchaseReport = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData!) as? [PacketPurchase])!
            //debugPrint(purchaseReport.debugDescription)
                debugPrint("Number of report available in UserData : " + String(purchaseReport.count))
                rowCount = purchaseReport.count + 1
            }catch{
                fatalError("Error occured while fetching purchase report array")
            }
        }else{
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("Row count : " + String(rowCount))
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        debugPrint("Getting cell for row num : " + String(indexPath.row))
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell", for: indexPath) as! ReportCell
        if(indexPath.row == (rowCount - 1)){
            debugPrint("Measuring Total at Row num : " + String(rowCount))
            cell.date.text = "Total"
            var totalPacks: Int = 0
            var totalCost: Double = 0.0
            for index in 0..<purchaseReport.count {
                totalPacks += purchaseReport[index].noOfPacks!
                totalCost += (purchaseReport[index].perPackCost! * Double(purchaseReport[index].noOfPacks!))
            }
            cell.noOfPacks.text = String(totalPacks)
            cell.price.text = String(Double(round(100*totalCost)/100))
            cell.layer.borderColor = UIColor.red.cgColor
            cell.layer.borderWidth = 2
        }else{
            cell.date.text = formatter.string(from: purchaseReport[indexPath.row].purchaseDate!)
            let packCnt = purchaseReport[indexPath.row].noOfPacks!
            let pckCost = purchaseReport[indexPath.row].perPackCost!
            cell.noOfPacks.text = String(packCnt)
            let CostDble = Double(packCnt) * pckCost
            cell.price.text = String(Double(round(100*CostDble)/100))
            cell.layer.borderWidth = 0
        }
        return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if(indexPath.row == (rowCount - 1)){
            return .none
        }
        return UITableViewCell.EditingStyle.delete
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //objects.remove(at: indexPath.row)
            debugPrint("***Going to delete the Row at : " + String(indexPath.row) + " ***")
            debugPrint("Before delete Row count : " + String(rowCount))
            purchaseReport.remove(at: indexPath.row)
            rowCount = purchaseReport.count + 1
            debugPrint("After delete Row count : " + String(rowCount))
            let data = try? NSKeyedArchiver.archivedData(withRootObject: purchaseReport, requiringSecureCoding: false)
            packData.set(data, forKey: "packData")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

