//
//  NyparkeringViewController.swift
//  ok2park
//
//  Created by Arbetskonto on 2017-04-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit

class NyparkeringViewController: UIViewController {
    @IBOutlet weak var avgiftstidView: UIView!
    @IBOutlet weak var zonView: UIView!
    @IBOutlet weak var middleBlockView: UIView!
    @IBOutlet weak var buyTicketButton: UIButton!
    @IBOutlet weak var reminderButton: UIButton!
    @IBOutlet weak var leftBlockView: UIView!
    @IBOutlet weak var rightBlockView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "GillSans-SemiBold", size: 20),
            NSForegroundColorAttributeName: UIColor.white
        ]*/
        
        reminderButton.roundedButton()
        
        middleBlockView.layer.cornerRadius = 10.0
        leftBlockView.layer.cornerRadius = 10.0
        rightBlockView.layer.cornerRadius = 10.0
        buyTicketButton.layer.cornerRadius = 10.0
        
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
    @IBAction func backButtonOnTouch(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
