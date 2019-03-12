//
//  ViewController.swift
//  Sample
//
//  Created by Yohei Noguchi on 2019/03/12.
//  Copyright © 2019 Yohei Noguchi. All rights reserved.
//

import UIKit
import TFAlertController

class ViewController: UIViewController, TFAlertControllerDelegate {
    
    var alertController: TFAlertController!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.alertController = TFAlertController(title: "Alert", description: "This is a test.");
        self.alertController.delegate = self;
    }


}

