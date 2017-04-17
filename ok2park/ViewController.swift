//
//  ViewController.swift
//  ok2park
//
//  Created by Johan Sveningsson on 2017-04-06.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit
//import KCFloatingActionButton

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
        /*for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }*/
        
       /* let fab = KCFloatingActionButton()
        fab.addItem("Hello, World!", icon: UIImage(named: "icon")!)
        self.view.addSubview(fab)*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func goToMinafordonSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowMinafordonSegue", sender: self)
    }

    @IBAction func goToNyparkeringSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ShowNyparkeringSegue", sender: self)
    }
}

