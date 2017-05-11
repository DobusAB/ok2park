//
//  MinafordonViewController.swift
//  ok2park
//
//  Created by Arbetskonto on 2017-04-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftyJSON

class MinafordonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var colorViewPurple: UIView!
    @IBOutlet weak var colorViewYellow: UIView!
    @IBOutlet weak var colorViewBlue: UIView!
    @IBOutlet weak var colorViewTeal: UIView!
    @IBOutlet weak var colorViewPink: UIView!
    @IBOutlet weak var colorViewDark: UIView!
    @IBOutlet weak var colorViewGray: UIView!
    @IBOutlet weak var colorViewGreen: UIView!
    @IBOutlet weak var colorViewInCell: UIView!
    
    @IBOutlet weak var chooseColorHeaderView: UIView!
    @IBOutlet weak var chooseColorView: UIView!
    @IBOutlet weak var addNewPlateView: UIView!
    @IBOutlet var addCarView: UIView!
    @IBOutlet weak var addNewVehicleButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var regNrTextField: UITextField!
    let ref = FIRDatabase.database().reference()
    
    var color_id = 0
    
    var offers = [JSON]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fordoncell", for: indexPath) as! FordonTableViewCell
        
        cell.selectionStyle = .none
        cell.fordonLabel.text = self.offers[indexPath.row]["reg_nr"].stringValue
        
        switch self.offers[indexPath.row]["color_id"].intValue {
        case 1:
            cell.colorView.backgroundColor = UIColor(red: 189 / 255.0, green: 15 / 255.0, blue: 225 / 255.0, alpha: 1.0)
            break
        case 2:
            cell.colorView.backgroundColor = UIColor(red: 73 / 255.0, green: 144 / 255.0, blue: 226 / 255.0, alpha: 1.0)
            break
        case 3:
            cell.colorView.backgroundColor = UIColor(red: 248 / 255.0, green: 233 / 255.0, blue: 28 / 255.0, alpha: 1.0)
            break
        case 4:
            cell.colorView.backgroundColor = UIColor(red: 80 / 255.0, green: 227 / 255.0, blue: 194 / 255.0, alpha: 1.0)
            break
        case 5:
            cell.colorView.backgroundColor = UIColor(red: 208 / 255.0, green: 1 / 255.0, blue: 27 / 255.0, alpha: 1.0)
            break
        case 6:
            cell.colorView.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
            break
        case 7:
            cell.colorView.backgroundColor = UIColor(red: 184 / 255.0, green: 233 / 255.0, blue: 134 / 255.0, alpha: 1.0)
            break
        case 8:
            cell.colorView.backgroundColor = UIColor(red: 216 / 255.0, green: 216 / 255.0, blue: 216 / 255.0, alpha: 1.0)
            break
        default:
            cell.colorView.backgroundColor = UIColor(red: 216 / 255.0, green: 216 / 255.0, blue: 216 / 255.0, alpha: 1.0)
        }
        // cell.offerNameLabel.text = self.offers[indexPath.row]["name"].stringValue
        // cell.offerParticipantsLabel.text = self.offers[indexPath.row]["participants"].stringValue + " st"
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.offer = offers[indexPath.row]
        
        self.performSegue(withIdentifier: "offerDetailSegue", sender: self)
        
    }*/
    
    func getOffers() {
        
        
        /* Alamofire.request("\(apiBaseURL)offers", method: .get, encoding: JSONEncoding.default, headers: authJSONHeaders)
            //Alamofire.request(.GET, "\(apiBaseURL)companies/\(self.user.companyId)/tickets", headers: authJSONHeaders, encoding: .JSON)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                if (response.result.error == nil) {
                    if let value = response.result.value {
                        
                        let json = JSON(value)
                        self.populateTableViewWithData(json["data"])
                    }
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                    debugPrint("HTTP Request failed: \(response.result.value)")
                }
        } */
        
        
        
        ref.child("data/cars").observe(FIRDataEventType.value, with: { (snapshot) in
            //let dict = snapshot.value as? [String : AnyObject] ?? [:]
            if let value = snapshot.value as? NSArray {
                
                let json = JSON(value)
                print(json)
                self.populateTableViewWithData(json)
                
            }
        })

        
        
        
    }
    
    func populateTableViewWithData(_ suppliers: JSON) {
        self.offers.removeAll()
        for (_, item) in suppliers {
            self.offers.append(item)
        }
        //let imageName = "emptystate"
        // let image = UIImage(named: imageName)
        //let imageView = UIImageView(image: image!)
        /*let height = self.view.frame.size.height
         let width = self.view.frame.size.width*/
        
        /*imageView.frame = CGRect(x: width/2 - 125, y: height/2 - 175, width: 250, height: 200)
         imageView.contentMode = .scaleAspectFit*/
        if self.offers.count == 0 {
            //ticketEmpty = true
            if tableView.backgroundView != nil {
                //tableView.backgroundView = UIImageView(image: UIImage(named: "emptystate"))
                //tableView.backgroundView!.addSubview(imageView)
                //imageView.layer.opacity = 1
            }
        } else {
            //ticketEmpty = false
            if tableView.backgroundView != nil {
                tableView.backgroundView!.layer.opacity = 1
            }
        }
        
        //print(ticketEmpty)
        
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        getOffers()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "GillSans-SemiBold", size: 20)!]
        
        /*self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "GillSans-SemiBold", size: 20),
            NSForegroundColorAttributeName: UIColor.white
        ]*/
        
        colorViewPurple.layer.cornerRadius = colorViewPurple.frame.size.width/2
        self.colorViewPurple.layer.masksToBounds = false
        
        colorViewYellow.layer.cornerRadius = colorViewYellow.frame.size.width/2
        self.colorViewYellow.layer.masksToBounds = false

        colorViewBlue.layer.cornerRadius = colorViewBlue.frame.size.width/2
        self.colorViewBlue.layer.masksToBounds = false

        colorViewTeal.layer.cornerRadius = colorViewTeal.frame.size.width/2
        self.colorViewTeal.layer.masksToBounds = false

        colorViewPink.layer.cornerRadius = colorViewPink.frame.size.width/2
        self.colorViewPink.layer.masksToBounds = false

        colorViewDark.layer.cornerRadius = colorViewDark.frame.size.width/2
        self.colorViewDark.layer.masksToBounds = false

        colorViewGray.layer.cornerRadius = colorViewGray.frame.size.width/2
        self.colorViewGray.layer.masksToBounds = false

        colorViewGreen.layer.cornerRadius = colorViewGreen.frame.size.width/2
        self.colorViewGreen.layer.masksToBounds = false

        hideKeyboardWhenTappedAround()

        chooseColorView.layer.shadowOpacity = 0.7
        chooseColorView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        chooseColorView.layer.shadowRadius = 5.0
        chooseColorView.layer.shadowColor = UIColor(red:0.51, green:0.51, blue:0.51, alpha:1.0).cgColor
        
        addNewPlateView.layer.shadowOpacity = 0.7
        addNewPlateView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        addNewPlateView.layer.shadowRadius = 5.0
        addNewPlateView.layer.shadowColor = UIColor(red:0.51, green:0.51, blue:0.51, alpha:1.0).cgColor
        
        addNewVehicleButton.layer.cornerRadius = 10.0
        self.addNewVehicleButton.layer.masksToBounds = false
        
        addNewPlateView.layer.cornerRadius = 10.0
        chooseColorView.layer.cornerRadius = 10.0
        chooseColorHeaderView.layer.cornerRadius = 10.0
        
        addNewVehicleButton.layer.shadowOpacity = 0.7
        addNewVehicleButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addNewVehicleButton.layer.shadowRadius = 5.0
        addNewVehicleButton.layer.shadowColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
        
        // Do any additional setup after loading the view.
        
        // Klick på colorViewPurple
        let buttonClickOnPurpleColor = UITapGestureRecognizer(target: self, action: #selector(MinafordonViewController.buttonClickOnPurpleColorFunc))
        
        colorViewPurple.isUserInteractionEnabled = true
        colorViewPurple.addGestureRecognizer(buttonClickOnPurpleColor)
        
        // Klick på colorViewBlue
        let buttonClickOnBlueColor = UITapGestureRecognizer(target: self, action: #selector(MinafordonViewController.buttonClickOnBlueColorFunc))
        
        colorViewBlue.isUserInteractionEnabled = true
        colorViewBlue.addGestureRecognizer(buttonClickOnBlueColor)
        
        // Klick på colorViewYellow
        let buttonClickOnYellowColor = UITapGestureRecognizer(target: self, action: #selector(MinafordonViewController.buttonClickOnYellowColorFunc))
        
        colorViewYellow.isUserInteractionEnabled = true
        colorViewYellow.addGestureRecognizer(buttonClickOnYellowColor)
        
        // Klick på colorViewTeal
        let buttonClickOnTealColor = UITapGestureRecognizer(target: self, action: #selector(MinafordonViewController.buttonClickOnTealColorFunc))
        
        colorViewTeal.isUserInteractionEnabled = true
        colorViewTeal.addGestureRecognizer(buttonClickOnTealColor)
        
        // Klick på colorViewPink
        let buttonClickOnPinkColor = UITapGestureRecognizer(target: self, action: #selector(MinafordonViewController.buttonClickOnPinkColorFunc))
        
        colorViewPink.isUserInteractionEnabled = true
        colorViewPink.addGestureRecognizer(buttonClickOnPinkColor)
        
        // Klick på colorViewDark
        let buttonClickOnDarkColor = UITapGestureRecognizer(target: self, action: #selector(MinafordonViewController.buttonClickOnDarkColorFunc))
        
        colorViewDark.isUserInteractionEnabled = true
        colorViewDark.addGestureRecognizer(buttonClickOnDarkColor)
        
        // Klick på colorViewGray
        let buttonClickOnGrayColor = UITapGestureRecognizer(target: self, action: #selector(MinafordonViewController.buttonClickOnGrayColorFunc))
        
        colorViewGray.isUserInteractionEnabled = true
        colorViewGray.addGestureRecognizer(buttonClickOnGrayColor)
        
        // Klick på colorViewGreen
        let buttonClickOnGreenColor = UITapGestureRecognizer(target: self, action: #selector(MinafordonViewController.buttonClickOnGreenColorFunc))
        
        colorViewGreen.isUserInteractionEnabled = true
        colorViewGreen.addGestureRecognizer(buttonClickOnGreenColor)
    }
    
    func buttonClickOnPurpleColorFunc(sender:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.colorViewPurple.alpha = 1
            self.colorViewYellow.alpha = 0.4
            self.colorViewBlue.alpha = 0.4
            self.colorViewTeal.alpha = 0.4
            self.colorViewPink.alpha = 0.4
            self.colorViewDark.alpha = 0.4
            self.colorViewGray.alpha = 0.4
            self.colorViewGreen.alpha = 0.4
            
            self.color_id = 1
            self.view.layoutIfNeeded()
        })
    }
    
    func buttonClickOnBlueColorFunc(sender:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.colorViewBlue.alpha = 1
            self.colorViewYellow.alpha = 0.4
            self.colorViewPurple.alpha = 0.4
            self.colorViewTeal.alpha = 0.4
            self.colorViewPink.alpha = 0.4
            self.colorViewDark.alpha = 0.4
            self.colorViewGray.alpha = 0.4
            self.colorViewGreen.alpha = 0.4
            
            self.color_id = 2
            
            self.view.layoutIfNeeded()
        })
    }
    
    func buttonClickOnYellowColorFunc(sender:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.colorViewYellow.alpha = 1
            self.colorViewBlue.alpha = 0.4
            self.colorViewPurple.alpha = 0.4
            self.colorViewTeal.alpha = 0.4
            self.colorViewPink.alpha = 0.4
            self.colorViewDark.alpha = 0.4
            self.colorViewGray.alpha = 0.4
            self.colorViewGreen.alpha = 0.4
            
            self.color_id = 3
            
            self.view.layoutIfNeeded()
        })
    }
    
    func buttonClickOnTealColorFunc(sender:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.colorViewTeal.alpha = 1
            self.colorViewBlue.alpha = 0.4
            self.colorViewPurple.alpha = 0.4
            self.colorViewYellow.alpha = 0.4
            self.colorViewPink.alpha = 0.4
            self.colorViewDark.alpha = 0.4
            self.colorViewGray.alpha = 0.4
            self.colorViewGreen.alpha = 0.4
            
            self.color_id = 4
            
            self.view.layoutIfNeeded()
        })
    }
    
    func buttonClickOnPinkColorFunc(sender:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.colorViewPink.alpha = 1
            self.colorViewBlue.alpha = 0.4
            self.colorViewPurple.alpha = 0.4
            self.colorViewYellow.alpha = 0.4
            self.colorViewTeal.alpha = 0.4
            self.colorViewDark.alpha = 0.4
            self.colorViewGray.alpha = 0.4
            self.colorViewGreen.alpha = 0.4
            
            self.color_id = 5
            
            self.view.layoutIfNeeded()
        })
    }
    
    func buttonClickOnDarkColorFunc(sender:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.colorViewDark.alpha = 1
            self.colorViewBlue.alpha = 0.4
            self.colorViewPurple.alpha = 0.4
            self.colorViewYellow.alpha = 0.4
            self.colorViewTeal.alpha = 0.4
            self.colorViewPink.alpha = 0.4
            self.colorViewGray.alpha = 0.4
            self.colorViewGreen.alpha = 0.4
            
            self.color_id = 6
            
            self.view.layoutIfNeeded()
        })
    }
    
    func buttonClickOnGreenColorFunc(sender:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.colorViewGreen.alpha = 1
            self.colorViewBlue.alpha = 0.4
            self.colorViewPurple.alpha = 0.4
            self.colorViewYellow.alpha = 0.4
            self.colorViewTeal.alpha = 0.4
            self.colorViewPink.alpha = 0.4
            self.colorViewGray.alpha = 0.4
            self.colorViewDark.alpha = 0.4
            
            self.color_id = 7
            
            self.view.layoutIfNeeded()
        })
    }
    
    func buttonClickOnGrayColorFunc(sender:UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            
            self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.8, y: 1.8)
            self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            
            self.colorViewGray.alpha = 1
            self.colorViewBlue.alpha = 0.4
            self.colorViewPurple.alpha = 0.4
            self.colorViewYellow.alpha = 0.4
            self.colorViewTeal.alpha = 0.4
            self.colorViewPink.alpha = 0.4
            self.colorViewGreen.alpha = 0.4
            self.colorViewDark.alpha = 0.4
            
            self.color_id = 8
            
            self.view.layoutIfNeeded()
        })
    }
    
    func resetButtons() {
        
        self.colorViewGray.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.colorViewBlue.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.colorViewPurple.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.colorViewYellow.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.colorViewTeal.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.colorViewPink.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.colorViewGreen.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.colorViewDark.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.colorViewGray.alpha = 0.4
        self.colorViewBlue.alpha = 0.4
        self.colorViewPurple.alpha = 0.4
        self.colorViewYellow.alpha = 0.4
        self.colorViewTeal.alpha = 0.4
        self.colorViewPink.alpha = 0.4
        self.colorViewGreen.alpha = 0.4
        self.colorViewDark.alpha = 0.4
        self.color_id = 0
    
    }
    
    func animateCloseButton() {
        UIView.animate(withDuration: 0.4) {
            self.addCarView.alpha = 0
        }
        let when = DispatchTime.now() + 1 // change integer to desired number of se   conds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.addCarView.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonOnTouch(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        animateCloseButton()
        self.resetButtons()
    }
    
    @IBAction func saveButtonOnTouch(_ sender: Any) {
        
        let count = self.offers.count
        let car = ["reg_nr" : self.regNrTextField.text!, "color_id": self.color_id] as [String : Any]
        ref.child("data/cars/\(count)").setValue(car)
        self.regNrTextField.text = ""
        
        self.animateCloseButton()
        self.resetButtons()
        
    }
    @IBAction func addNewVehicleButtonOnTouch(_ sender: Any) {
        animateIn()
    }

    func animateIn() {
        self.view.addSubview(addCarView)
        //self.addCarView.bindFrameToSuperviewBounds()
        addCarView.center = self.view.center
        
        addCarView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        addCarView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.addCarView.alpha = 1
            self.addCarView.transform = CGAffineTransform.identity
            
        }
    }

    @IBAction func backButtonOnTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
