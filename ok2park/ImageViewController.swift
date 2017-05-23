//
//  ImageViewController.swift
//  ok2park
//
//  Created by Johan Sveningsson on 2017-05-11.
//  Copyright © 2017 Johan Sveningsson. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var item: String = ""

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: "\(item)")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        
        self.dismiss(animated: true) {}
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
