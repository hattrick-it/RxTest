//
//  ViewController.swift
//  TestRx
//
//  Created by Rocket League on 4/2/18.
//  Copyright © 2018 Rocket League. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var environmentLabel: UILabel!
    @IBOutlet var serverBaseURLLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        environmentLabel.text = "Environment: \(ConfigurationManager.environment.rawValue.capitalized)"
        serverBaseURLLabel.text = "Server Base URL: \(ConfigurationManager.sharedInstance.serverBaseURL)"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

