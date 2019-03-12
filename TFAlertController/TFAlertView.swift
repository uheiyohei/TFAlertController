//
//  PopUpTextFieldView.swift
//  LookUpList
//
//  Created by Yohei Noguchi on 2017/08/15.
//  Copyright © 2017年 Yohei Noguchi. All rights reserved.
//

import UIKit

class TFAlertView: UIView {
    
    var titleLabel: UILabel!;
    var descriptionLabel: UILabel!;
    var textField: UITextField!;
    var doneButton: UIButton!;
    var cancelButton: UIButton!;

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.backgroundColor = .white;
        
        self.titleLabel = UILabel(frame: CGRect(x: self.frame.minX + 30, y: self.frame.minY + 30, width: 0, height: 0));
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0);
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.sizeToFit();
        self.addSubview(self.titleLabel);
        
        self.descriptionLabel = UILabel(frame: CGRect(x: titleLabel.frame.minX, y: titleLabel.frame.maxY + 10, width: self.frame.width - (titleLabel.frame.minX * 2), height: 0));
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 15.0);
        self.descriptionLabel.textColor = .gray;
        self.descriptionLabel.lineBreakMode = .byWordWrapping;
        self.descriptionLabel.numberOfLines = 0;
        self.descriptionLabel.sizeToFit();
        self.addSubview(self.descriptionLabel);
        
        self.textField = UITextField(frame: CGRect(x: titleLabel.frame.minX, y: descriptionLabel.frame.maxY + 20, width: self.frame.maxX - 30 - titleLabel.frame.minX, height: 30));
        self.textField.borderStyle = .none;
        self.textField.clearButtonMode = .whileEditing;
        self.textField.autocapitalizationType = .none;
        self.textField.enablesReturnKeyAutomatically = true;
        self.textField.returnKeyType = .done;
        self.textField.becomeFirstResponder();
        self.addSubview(self.textField);
        
        let textFieldUnderLine: CALayer = CALayer();
        textFieldUnderLine.borderColor = UIColor.black.cgColor;
        let borderWidth: CGFloat = 1.0;
        textFieldUnderLine.frame = CGRect(x: 0, y: self.textField.frame.height - borderWidth, width: self.textField.frame.width, height: borderWidth);
        textFieldUnderLine.borderWidth = borderWidth;
        self.textField?.layer.addSublayer(textFieldUnderLine);
        
        let normalButtonColor = UIColor(red: 27 / 1.2 / 255, green: 137 / 1.2 / 255, blue: 211 / 1.2 / 255, alpha: 1.0);
        let highlightedButtonColor = UIColor(red: 27 / 255, green: 137 / 255, blue: 211 / 255, alpha: 1.0);
        
        self.doneButton = UIButton(frame: CGRect.zero);
        self.doneButton.setTitle(NSLocalizedString("Done", comment: ""), for: .normal);
        self.doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: self.doneButton.titleLabel!.font.pointSize);
        self.doneButton.setTitleColor(normalButtonColor, for: .normal);
        self.doneButton.setTitleColor(highlightedButtonColor, for: .highlighted);
        self.doneButton.setTitleColor(.gray, for: .disabled);
        self.doneButton.sizeToFit();
        self.doneButton.frame.origin = CGPoint(x: self.textField.frame.maxX - 20 - self.doneButton.frame.width, y: self.textField.frame.maxY + 20);
        self.addSubview(self.doneButton);
        
        self.cancelButton = UIButton(frame: CGRect.zero);
        self.cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal);
        self.cancelButton.setTitleColor(normalButtonColor, for: .normal);
        self.cancelButton.setTitleColor(highlightedButtonColor, for: .highlighted);
        self.cancelButton.sizeToFit();
        self.cancelButton.frame.origin = CGPoint(x: self.doneButton.frame.minX - 50 - self.cancelButton.frame.width, y: self.doneButton.frame.origin.y);
        self.addSubview(self.cancelButton);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.frame.size.height = self.cancelButton.frame.maxY + 20;
    }

}
