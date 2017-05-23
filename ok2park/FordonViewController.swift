//
//  FordonViewController.swift
//  ok2park
//
//  Created by Johan Sveningsson on 2017-05-15.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import SwiftMessages

class FordonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var offers = [JSON]()
    let ref = FIRDatabase.database().reference()
    
    var id:Int = 0

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closeModal(_ sender: Any) {
        self.dismiss(animated: true) { 
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getOffers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = [
            "reg_nr": String(describing: self.offers[indexPath.row]["reg_nr"])
        ] as [String: Any];
        
        print(self.id)
        
        
        ref.child("data/locations/\(self.id)").updateChildValues(data)
        
        self.dismiss(animated: true) { 
            let view = MessageView.viewFromNib(layout: .MessageView)
            var config = SwiftMessages.Config()
            config.duration = .seconds(seconds: 5)
            view.configureContent(title: "Lagt till bil" , body: "Du har nu lagt till en bil till parkeringen")
            // Show the message.
            SwiftMessages.show(config: config, view: view)
            SwiftMessages.show(view: view)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fordonadd", for: indexPath) as! FordonCreateTableViewCell
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
