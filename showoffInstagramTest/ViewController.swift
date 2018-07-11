//
//  ViewController.swift
//  showoffInstagramTest
//
//  Created by Conor Forrest on 04/07/2018.
//  Copyright © 2018 ElaineCo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var loginInsta: UIButton!
    @IBAction func loginInstagram(_ sender: UIButton) {
        performSegue(withIdentifier: "instagramLogon", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // following functions set navigation bar invisible
    // in this view and make it reappear for other views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //show the navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        //hide the navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

