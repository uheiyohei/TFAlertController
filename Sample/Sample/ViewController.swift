//
//  ViewController.swift
//  Sample
//
//  Copyright © 2019 Yohei Noguchi. All rights reserved.
//

import UIKit
import TFAlertController

class ViewController: UIViewController {
    
    var alertController: TFAlertController!;

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect.zero);
        button.setTitle("Alert", for: .normal);
        button.setTitleColor(.blue, for: .normal);
        button.sizeToFit();
        button.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY);
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside);
        self.view.addSubview(button);
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: 30));
        label.font = UIFont.systemFont(ofSize: 25.0);
        label.textAlignment = .center;
        label.center = CGPoint(x: self.view.frame.midX, y: button.frame.maxY - 100);
        self.view.addSubview(label);
        
        self.alertController = TFAlertController(title: "Alert", description: "The description shows here", handler: {(text: String) in
            label.text = text;
        });
        
        // You can customize all of the alert view's components; title label, description label, text field, "Done" button, "Cancel" button.
        // For example
        self.alertController.alertView.textField.text = "Default text";
        self.alertController.alertView.doneButton.setTitleColor(.red, for: .normal);
    }
    
    @objc func buttonTapped() {
        self.present(self.alertController, animated: true, completion: nil);
    }
}

