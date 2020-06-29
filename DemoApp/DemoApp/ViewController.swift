//
//  ViewController.swift
//  DemoApp
//
//  Created by Deniz Adalar on 30/05/2020.
//  Copyright © 2020 Incall Ltd. All rights reserved.
//

import UIKit
import SmartCalling

class ViewController: UIViewController {

  @IBOutlet private var textField: UITextField!

  @IBAction func updateProfiles() {
    SmartCallingManager.shared.updateProfiles { error in
      DispatchQueue.main.async {
        if let error = error {
          let alert = UIAlertController(title: "Profile Update Failed", message: error.localizedDescription, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        } else {
          let alert = UIAlertController(title: "Success", message: "Profiles updated", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
      }
    }
  }

  @IBAction func setClientId() {
    SmartCallingManager.shared.setClientId(textField.text) { error in
      DispatchQueue.main.async {
        if let error = error {
          let alert = UIAlertController(title: "Set Client Id Failed", message: error.localizedDescription, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        } else {
          let alert = UIAlertController(title: "Success", message: "Client Id set", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
      }
    }
  }

}

