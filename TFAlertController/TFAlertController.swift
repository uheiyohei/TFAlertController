//
//  TFAlertController.swift
//  TFAlertController
//
//  Copyright © 2019 Yohei Noguchi. All rights reserved.
//

import UIKit

public class TFAlertController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    public var alertView: TFAlertView;
    public var handler: ((String) -> Void)?;
    
    public init(title: String, description: String?, handler: ((String) -> Void)?) {
        self.handler = handler;
        
        self.alertView = TFAlertView();
        self.alertView.titleLabel.text = title;
        self.alertView.descriptionLabel.text = description;
        
        super.init(nibName: nil, bundle: nil);
        
        self.modalPresentationStyle = .overCurrentContext;
        self.modalTransitionStyle = .crossDissolve;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5);
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(lowerLayerTapped));
        tapGestureRecognizer.delegate = self;
        self.view.addGestureRecognizer(tapGestureRecognizer);
        
        self.alertView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 60, height: 0);
        self.alertView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY);
        self.alertView.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside);
        self.alertView.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside);
        self.alertView.textField.delegate = self;
        self.view.addSubview(self.alertView);
        
        let notificationCenter: NotificationCenter = .default;
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(textFieldTextChanged), name: UITextField.textDidChangeNotification, object: nil);
        
        self.textFieldTextChanged();
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.alertView.updateConstraints();
        self.alertView.textField.becomeFirstResponder();
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func doneButtonPressed(button: UIButton) {
        self.dismiss(animated: true, completion: nil);
        self.handler?(self.alertView.textField.text!);
    }
    
    @objc private func cancelButtonPressed(button: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @objc private func lowerLayerTapped(gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil);
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view == self.alertView) {
            return false;
        }
        return true;
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo!;
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue;
        self.alertView.center = CGPoint(x: self.view.frame.midX, y: keyboardFrame.minY / 2);
    }
    
    @objc private func keyboardWillHide() {
        self.alertView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY);
    }
    
    @objc private func textFieldTextChanged() {
        if (self.alertView.textField.text == "") {
            self.alertView.doneButton.isEnabled = false;
        } else {
            self.alertView.doneButton.isEnabled = true;
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true, completion: nil);
        self.handler?(self.alertView.textField.text!);
        
        return true;
    }
}
