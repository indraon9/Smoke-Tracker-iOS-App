//
//  FirstViewController.swift
//  SmokeTraker
//
//  Created by Indranil Ghosh on 6/16/19.
//  Copyright © 2019 Apple Tech. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var purchaseDate: UIDatePicker!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var perPackCost: UITextField!
    let packData = UserDefaults.standard
    var counter = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        purchaseDate.setValue(UIColor.white, forKey: "textColor")
        packData.integer(forKey: "packCounts")
        output.text = "\(counter)"
        if packData.value(forKey: "perPackCost") != nil {
            perPackCost.text = String(packData.double(forKey: "perPackCost"))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func packStepper(_ sender: UIStepper) {
        counter = Int(sender.value)
        output.text = "\(counter)"
    }
    @IBAction func storePurchase(_ sender: UIButton) {
        print("This is storePurchase")
        packData.set(output.text, forKey: "packCounts")
        let cost :Double? = Double(perPackCost.text!)
        guard cost != nil else {
            return
        }
        packData.set(cost, forKey: "perPackCost")
        let storedData = packData.data(forKey: "packData")
        if storedData != nil{
            do {
            guard var decodedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedData!) as? [PacketPurchase] else{
                fatalError("loadWidgetDataArray - Can't get Array")
            }
                debugPrint(decodedData.debugDescription)
                debugPrint(decodedData.count)
                decodedData.append(PacketPurchase(noOfPacks: counter, purchaseDate: purchaseDate.date, perPackCost: cost ?? 0.0))
                let data = try? NSKeyedArchiver.archivedData(withRootObject: decodedData, requiringSecureCoding: false)
                packData.set(data, forKey: "packData")
            }catch{
                fatalError("loadWidgetDataArray - Can't encode data: \(error)")
            }
            //debugPrint(decodedData.debugDescription)
            //debugPrint(decodedData.count)
            //decodedData.append(PacketPurchase(noOfPacks: counter, purchaseDate: purchaseDate.date, perPackCost: cost ?? 0.0))
            //let data = NSKeyedArchiver.archivedData(withRootObject: storedData!)
            //debugPrint(data, separator: "Data exists")
            //packData.set(data, forKey: "packData")
        }else{
            var newData: [PacketPurchase] = []
            newData.append(PacketPurchase(noOfPacks: counter, purchaseDate: purchaseDate.date, perPackCost: cost ?? 0.0))
            let data = try? NSKeyedArchiver.archivedData(withRootObject: newData, requiringSecureCoding: false)
            packData.set(data, forKey: "packData")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
