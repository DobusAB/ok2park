//
//  NyparkeringViewController.swift
//  ok2park
//
//  Created by Arbetskonto on 2017-04-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit
import UserNotifications
import SwiftMessages
import Firebase

class NyparkeringViewController: UIViewController {
    @IBOutlet weak var avgiftstidView: UIView!
    @IBOutlet weak var zonView: UIView!
    @IBOutlet weak var middleBlockView: UIView!
    @IBOutlet weak var buyTicketButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var leftBlockView: UIView!
    @IBOutlet weak var rightBlockView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var reminderPopupView: UIView!
    @IBOutlet var wholePopupView: UIView!
    @IBOutlet weak var popupHeaderView: UIView!
    @IBOutlet var wholeSignsPopupView: UIView!
    @IBOutlet weak var signsContainerView: UIView!
    @IBOutlet weak var paytimeLabel: UILabel!
    @IBOutlet weak var zoneLabel: UILabel!
    @IBOutlet weak var addParkButton: UIButton!
    
    @IBOutlet weak var regNrLabel: UILabel!
    @IBOutlet weak var cityPicView: UIImageView!
    var item = [String: Any]()
    
    let ref = FIRDatabase.database().reference()
    
    var id = 0;
    var hasReg: Bool = false;
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.yourCarPark.isHidden = true
        getDetail()
    }
    
    @IBOutlet weak var yourCarPark: UIView!
    @IBAction func addParkButton(_ sender: Any) {
        if(hasReg == false)
        {
            self.performSegue(withIdentifier: "showCars", sender: self)
        }else {
            ref.child("data/locations/\(self.id)/reg_nr").removeValue()
            
            self.dismiss(animated: true, completion: { 
                let view = MessageView.viewFromNib(layout: .MessageView)
                var config = SwiftMessages.Config()
                config.duration = .seconds(seconds: 5)
                view.configureContent(title: "Avslutad parkering" , body: "Du har nu avslutat din parkering")
                // Show the message.
                SwiftMessages.show(config: config, view: view)
                SwiftMessages.show(view: view)
            })
            
        }
        
    }
    
    func getDetail() {
    
        if let id = item["id"] as? Int {
            self.ref.child("data/locations/\(id)").observe(FIRDataEventType.value, with: { (snapshot) in
                if snapshot.value != nil {
                    let json = JSON(snapshot.value!)
                    self.zoneLabel.text = json["zone"].stringValue
                    self.paytimeLabel.text = json["pay_time"].stringValue
                    self.cityPicView.image = UIImage(named: "\(json["background_image"].stringValue)")
                    self.id = id
                    
                    if(json["reg_nr"].exists())
                    {
                        self.yourCarPark.isHidden = false
                        self.regNrLabel.text = json["reg_nr"].stringValue
                        self.addParkButton.setTitle("Avsluta parkering", for: .normal)
                        self.hasReg = true
                    }
                }
                //let dict = snapshot.value as? [String : AnyObject] ?? [:]
            })
        }
    }
    
    @IBOutlet weak var datepicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(item)
        
        /* if let zones = item["zone"] {
            self.zoneLabel.text = zones as? String
        }
        
        if let pay_time = item["pay_time"] as? String {
            self.paytimeLabel.text = pay_time
        }
        
        if let background_image = item["background_image"] as? String {
            cityPicView.image = UIImage(named: "\(background_image)")
        }*/
        
        
        
        
        /*self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "GillSans-SemiBold", size: 20),
            NSForegroundColorAttributeName: UIColor.white
        ]*/
        
        signsContainerView.layer.cornerRadius = 10.0
        self.signsContainerView.layer.masksToBounds = false
        
        popupHeaderView.roundedButton2()
        
        containerView.layer.cornerRadius = 10.0
        self.containerView.layer.masksToBounds = false
        
        reminderButton.roundedButton()
        
        middleBlockView.layer.cornerRadius = 10.0
        leftBlockView.layer.cornerRadius = 10.0
        
        
        rightBlockView.layer.cornerRadius = 10.0
        buyTicketButton.layer.cornerRadius = 10.0
        addParkButton.layer.cornerRadius = 10.0
        
        middleBlockView.layer.shadowOpacity = 0.7
        middleBlockView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        middleBlockView.layer.shadowRadius = 5.0
        middleBlockView.layer.shadowColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0).cgColor
        
        leftBlockView.layer.shadowOpacity = 0.7
        leftBlockView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        leftBlockView.layer.shadowRadius = 5.0
        leftBlockView.layer.shadowColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0).cgColor
        
        rightBlockView.layer.shadowOpacity = 0.7
        rightBlockView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        rightBlockView.layer.shadowRadius = 5.0
        rightBlockView.layer.shadowColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0).cgColor
        
        buyTicketButton.layer.shadowOpacity = 0.7
        buyTicketButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        buyTicketButton.layer.shadowRadius = 5.0
        buyTicketButton.layer.shadowColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0).cgColor
        
        addParkButton.layer.shadowOpacity = 0.7
        addParkButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        addParkButton.layer.shadowRadius = 5.0
        addParkButton.layer.shadowColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.0).cgColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func animateCloseButton() {
        UIView.animate(withDuration: 0.4) {
            self.wholePopupView.alpha = 0
        }
        let when = DispatchTime.now() + 1 // change integer to desired number of se   conds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.wholePopupView.removeFromSuperview()
        }
    }
    
    func animateIn() {
        self.view.addSubview(wholePopupView)
        //containerView.bindFrameToSuperviewBounds()
        wholePopupView.center = self.view.center
        
        wholePopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        wholePopupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.wholePopupView.alpha = 1
            self.wholePopupView.transform = CGAffineTransform.identity
            
        }
    }
    
    func animateCloseButton2() {
        UIView.animate(withDuration: 0.4) {
            self.wholeSignsPopupView.alpha = 0
        }
        let when = DispatchTime.now() + 1 // change integer to desired number of se   conds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.wholeSignsPopupView.removeFromSuperview()
        }
    }
    
    func animateIn2() {
        self.view.addSubview(wholeSignsPopupView)
        //containerView.bindFrameToSuperviewBounds()
        wholeSignsPopupView.center = self.view.center
        
        wholeSignsPopupView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        wholeSignsPopupView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.wholeSignsPopupView.alpha = 1
            self.wholeSignsPopupView.transform = CGAffineTransform.identity
            
        }
    }
    
    @IBAction func backButtonOnTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func reminderButtonOnTouch(_ sender: Any) {
        animateIn()
    }

    @IBAction func cancelReminderButtonOnTouch(_ sender: Any) {
        animateCloseButton()
    }
    
    @IBAction func successReminderButtonOnTouch(_ sender: Any) {
        // Success
        let date = self.datepicker.date
        
        /*let fiften =  (15.0 * 60.0)
        let unix = date.timeIntervalSince1970*/
        
        //let new_date = (unix - fiften)
        
        //let toPost = NSDate(timeIntervalSince1970: new_date)
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.scheduleNotification(at: date)
        
        
        
        let view = MessageView.viewFromNib(layout: .MessageView)
        var config = SwiftMessages.Config()
        config.duration = .seconds(seconds: 5)
        view.configureContent(title: "Skapad påminnelse" , body: "Du har nu skapat en påminnelse.")
        // Show the message.
        SwiftMessages.show(config: config, view: view)
        SwiftMessages.show(view: view)
        
        animateCloseButton()
        
        
        
        
        // print(toPost)
        

    }
    
    @IBAction func seeSignsButtonOnTouch(_ sender: Any) {
        // animateIn2()
        performSegue(withIdentifier: "GoToImage", sender: self)
        print("show image")
    }
    
    @IBAction func seeSignsCloseButtonOnTouch(_ sender: Any) {
        animateCloseButton2()
    }
    @IBAction func findParkActionButton(_ sender: Any) {
        
        let coordinate = self.item["coordinate"] as! CLLocationCoordinate2D
        
        let url = "http://maps.apple.com/maps?daddr=\(coordinate.latitude),\(coordinate.longitude)"
        UIApplication.shared.openURL(URL(string:url)!)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "GoToImage")
        {
            let controller = segue.destination as! ImageViewController
            
            
            controller.item = self.item["park_sign"] as! String

        }
        if(segue.identifier == "showCars")
        {
            let controller = segue.destination as! FordonViewController
            
            controller.id = self.id
        }
    }
    
    

}
