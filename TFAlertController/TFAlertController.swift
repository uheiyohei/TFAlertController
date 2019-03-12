//
//  TFAlertController.swift
//  TFAlertController
//
//  Created by Yohei Noguchi on 2019/03/05.
//  Copyright © 2019 Yohei Noguchi. All rights reserved.
//

import UIKit

public protocol TFAlertControllerDelegate {
    func alertTextFieldDidEndEditing(text: String);
}

public class TFAlertController: UIViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    public var alertView: TFAlertView!;
    public var delegate: TFAlertControllerDelegate?;
    
    public init(title: String, description: String?) {
        super.init(nibName: nil, bundle: nil);
        
        self.alertView = TFAlertView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 60, height: 200));
        self.alertView.titleLabel.text = title;
        self.alertView.descriptionLabel.text = description;
        
        self.modalPresentationStyle = .overCurrentContext;
        self.modalTransitionStyle = .crossDissolve;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5);
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(lowerLayerTapped));
        tapGestureRecognizer.delegate = self;
        self.view.addGestureRecognizer(tapGestureRecognizer);
        
        self.alertView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY);
        self.alertView.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside);
        self.alertView.cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside);
        self.view.addSubview(self.alertView);
        
        let notificationCenter: NotificationCenter = .default;
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(textFieldTextChanged), name: UITextField.textDidChangeNotification, object: nil);
        
        self.alertView.textField.delegate = self;
        self.textFieldTextChanged();
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func doneButtonPressed(button: UIButton) {
        self.dismiss(animated: true, completion: nil);
        self.delegate?.alertTextFieldDidEndEditing(text: self.alertView.textField.text!);
    }
    
    @objc private func cancelButtonPressed(button: UIButton) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @objc private func lowerLayerTapped(gesture: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil);
    }
    
    private func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
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
    
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismiss(animated: true, completion: nil);
        self.delegate?.alertTextFieldDidEndEditing(text: textField.text!);
        
        return true;
    }
}
