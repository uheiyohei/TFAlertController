# TFAlertController

## About

TFAlertController is a framework of an alert view with text field for iOS.

![Image](/Demo/DemoImage.png)

## Installation

### Carthage
`github "uheiyohei/TFAlertController"`

## Usage
```Swift
import TFAlertController

let alertController = TFAlertController(title: "Title", description: "The description of the alert." handler: {
  (text: String) in
  label.text = text // You can get the text written in the field.
})

// The parts on the alert view are customizable.
alertController.alertView.textField.text = "Default text";
alertController.alertView.doneButton.setTitle("OK", for: .normal);

self.present(alertController, animated: true, completion: nil)

```

* The description and the handler are **optional**.
* The parts on the alert view are completely **customizable**.(e.g. title label, text field, "Done" button, etc.)
