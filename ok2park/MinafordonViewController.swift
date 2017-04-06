//
//  MinafordonViewController.swift
//  ok2park
//
//  Created by Arbetskonto on 2017-04-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit

class MinafordonViewController: UIViewController {
    @IBOutlet weak var colorViewPurple: UIView!
    @IBOutlet weak var colorViewYellow: UIView!
    @IBOutlet weak var colorViewBlue: UIView!
    @IBOutlet weak var colorViewTeal: UIView!
    @IBOutlet weak var colorViewPink: UIView!
    @IBOutlet weak var colorViewDark: UIView!
    @IBOutlet weak var colorViewGray: UIView!
    @IBOutlet weak var colorViewGreen: UIView!

    @IBOutlet weak var chooseColorHeaderView: UIView!
    @IBOutlet weak var chooseColorView: UIView!
    @IBOutlet weak var addNewPlateView: UIView!
    @IBOutlet var addCarView: UIView!
    @IBOutlet weak var addNewVehicleButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "GillSans-SemiBold", size: 20)!]
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "GillSans-SemiBold", size: 20),
            NSForegroundColorAttributeName: UIColor.white
        ]
        
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
        
        addNewVehicleButton.layer.cornerRadius = 2.0
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
            
            self.view.layoutIfNeeded()
        })
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

}
