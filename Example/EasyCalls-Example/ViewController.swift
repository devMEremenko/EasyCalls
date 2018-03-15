//
//  ViewController.swift
//  EasyCalls-Example
//
//  Created by Maxim Eremenko on 3/13/18.
//  Copyright © Maxim Eremenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {}

extension ViewController {
    
    @IBAction func showSimpleAlert(_ sender: UIButton) {
        show(title: "Simple Alert", actions: Action.ok)
    }
    
    @IBAction func showOkCancelAlert(_ sender: UIButton) {
        
        let ok = Action.ok { _ in
            // handle ok
        }
        
        let cancel = Action.cancel { _ in
            // handle cancel
        }
        
        show(title: "More complex alert", actions: cancel, ok)
    }
    
    @IBAction func showCustomAlert(_ sender: UIButton) {
        
        let action = Action.with(title: "Custom Action", style: .default) { _ in
            // handle action
        }
        
        show(title: "Custom", message: "Alert", style: .alert, completion: {
            // perform work when the alert has been presented
        }, actions: [action])
    }
    
    @IBAction func showActionSheet(_ sender: UIButton) {
        
        show(title: "Custom",
             message: "Alert",
             style: .actionSheet,
             actions: [Action.ok])
    }
    
    @IBAction func showOwnAlert(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Alert",
                                      message: "Message",
                                      preferredStyle: .alert)
        alert.addAction(Action.ok)
        show(alert: alert)
    }
}
