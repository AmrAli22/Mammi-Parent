//
//  TheEventViewController.swift
//  Mammi-Parent
//
//  Created by Sayed Abdo on 10/17/18.
//  Copyright © 2018 Hamza. All rights reserved.
//

import UIKit

class TheEventViewController: UIViewController {

    @IBOutlet weak var TxtFieldEventName: UITextField!
    @IBOutlet weak var TxtFieldEventDate: UITextField!
    @IBOutlet weak var TxtFieldEventCost: UITextField!
    @IBOutlet weak var TxtFieldEventAttends: UITextField!
    @IBOutlet weak var TxtViewEventDesc: UITextView!
    @IBOutlet weak var ImgViewEventImg: UIImageView!
    
    @IBOutlet weak var BtnActBack: UIButton!
    @IBOutlet weak var BtnGoing: UIButton!
    
    @IBAction func BtnActBackDis(_ sender: Any) {
        
        dismiss(animated: true)

    }
    var CurrentEvent = Event(_name: "", _img: #imageLiteral(resourceName: "hd1") , _Desc: "", _Date: "", _Cost: "", _Attends: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.TxtViewEventDesc.makeRoundedShapes()
        self.TxtFieldEventName.makeRoundedShapes()
        self.TxtFieldEventAttends.makeRoundedShapes()
        self.TxtFieldEventCost.makeRoundedShapes()
        self.TxtFieldEventDate.makeRoundedShapes()
        
        self.BtnGoing.makeRoundedShapes()
     
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.TxtViewEventDesc.text = CurrentEvent.Desc
        self.TxtFieldEventName.text = CurrentEvent.name
        self.TxtFieldEventAttends.text  = "\(String(CurrentEvent.Attends)) Partcipant"
        self.TxtFieldEventCost.text = "\(CurrentEvent.Cost) L.E"
        self.TxtFieldEventDate.text = CurrentEvent.Date
        self.ImgViewEventImg.image = CurrentEvent.img
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BtnActGoingPressed(_ sender: Any) {
    }
    
}
