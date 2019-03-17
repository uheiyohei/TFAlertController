//
//  TFAlertView.swift
//  TFAlertView
//
//  Copyright © 2019 Yohei Noguchi. All rights reserved.
//

import UIKit

public class TFAlertView: UIView {
    
    public var titleLabel: UILabel;
    public var descriptionLabel: UILabel;
    public var textField: UITextField;
    public var doneButton: UIButton;
    public var cancelButton: UIButton;

    public init() {
        self.titleLabel = UILabel(frame: CGRect.zero);
        self.descriptionLabel = UILabel(frame: CGRect.zero);
        self.textField = UITextField(frame: CGRect.zero);
        self.doneButton = UIButton(frame: CGRect.zero);
        self.cancelButton = UIButton(frame: CGRect.zero);
        
        super.init(frame: CGRect.zero);
        
        self.backgroundColor = .white;
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0);
        self.titleLabel.numberOfLines = 0;
        self.addSubview(self.titleLabel);
        
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 15.0);
        self.descriptionLabel.textColor = .gray;
        self.descriptionLabel.lineBreakMode = .byWordWrapping;
        self.descriptionLabel.numberOfLines = 0;
        self.addSubview(self.descriptionLabel);
        
        self.textField.borderStyle = .none;
        self.textField.clearButtonMode = .whileEditing;
        self.textField.autocapitalizationType = .none;
        self.textField.enablesReturnKeyAutomatically = true;
        self.textField.returnKeyType = .done;
        self.addSubview(self.textField);
        
        let normalButtonColor = UIColor(red: 27 / 1.2 / 255, green: 137 / 1.2 / 255, blue: 211 / 1.2 / 255, alpha: 1.0);
        let highlightedButtonColor = UIColor(red: 27 / 255, green: 137 / 255, blue: 211 / 255, alpha: 1.0);
        
        self.doneButton.setTitle("Done", for: .normal);
        self.doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: self.doneButton.titleLabel!.font.pointSize);
        self.doneButton.setTitleColor(normalButtonColor, for: .normal);
        self.doneButton.setTitleColor(highlightedButtonColor, for: .highlighted);
        self.doneButton.setTitleColor(.gray, for: .disabled);
        self.addSubview(self.doneButton);
        
        self.cancelButton.setTitle("Cancel", for: .normal);
        self.cancelButton.setTitleColor(normalButtonColor, for: .normal);
        self.cancelButton.setTitleColor(highlightedButtonColor, for: .highlighted);
        self.addSubview(self.cancelButton);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func updateConstraints() {
        super.updateConstraints();
        
        self.titleLabel.frame = CGRect(x: 30, y: 30, width: 0, height: 0);
        self.titleLabel.sizeToFit();
        
        self.descriptionLabel.frame = CGRect(x: titleLabel.frame.minX, y: titleLabel.frame.maxY + 10, width: self.frame.width - (titleLabel.frame.minX * 2), height: 0);
        self.descriptionLabel.sizeToFit();
        
        self.textField.frame = CGRect(x: titleLabel.frame.minX, y: descriptionLabel.frame.maxY + 20, width: self.frame.width - self.titleLabel.frame.minX * 2, height: 30);
        
        let textFieldUnderLine: CALayer = CALayer();
        textFieldUnderLine.borderColor = UIColor.black.cgColor;
        let borderWidth: CGFloat = 1.0;
        textFieldUnderLine.frame = CGRect(x: 0, y: self.textField.frame.height - borderWidth, width: self.textField.frame.width, height: borderWidth);
        textFieldUnderLine.borderWidth = borderWidth;
        self.textField.layer.addSublayer(textFieldUnderLine);
        
        self.doneButton.sizeToFit();
        self.doneButton.frame.origin = CGPoint(x: self.textField.frame.maxX - 20 - self.doneButton.frame.width, y: self.textField.frame.maxY + 20);
        
        self.cancelButton.sizeToFit();
        self.cancelButton.frame.origin = CGPoint(x: self.doneButton.frame.minX - 50 - self.cancelButton.frame.width, y: self.doneButton.frame.origin.y);
        
        self.frame.size.height = self.cancelButton.frame.maxY + 20;
    }

}
