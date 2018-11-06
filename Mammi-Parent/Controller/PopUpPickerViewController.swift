//
//  PopUpPickerViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/29/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class PopUpPickerViewController: UIViewController {

     @IBOutlet weak var BtnGetReport: UIButton!
     @IBOutlet weak var DatePicker: UIDatePicker!
    var ChossenDate = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        DatePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        DatePicker.makeRoundedShapes()
        DatePicker.backgroundColor = #colorLiteral(red: 1, green: 0.6043758988, blue: 0.6024207473, alpha: 1)
        BtnGetReport.makeRoundedShapes()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            ChossenDate = "\(day)/\(month)/\(year)"
        }
    }
    
    @IBAction func BtnActGetReport(_ sender: Any) {
        
        let ReportVC = ReportViewController()
        ReportVC.ChoosenDateFromPicker = ChossenDate
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()

    }
}
