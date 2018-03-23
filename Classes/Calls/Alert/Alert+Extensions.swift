//
//  Alert+Extensions.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/13/18.
//  Copyright © 2018 Maxim Eremenko. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func show(message: String?, actions: UIAlertAction...) {
        
        show(title: nil,
             message: message,
             style: Configuration.Alert.style,
             completion: nil,
             actions: actions)
    }
    
    func show(title: String?,
              style: UIAlertControllerStyle,
              actions: UIAlertAction...) {
        
        show(title: title,
             message: nil,
             style: Configuration.Alert.style,
             completion: nil,
             actions: actions)
    }
    
    func show(title: String?, actions: UIAlertAction...) {
        
        show(title: title,
             message: nil,
             style: Configuration.Alert.style,
             completion: nil,
             actions: actions)
    }
    
    func show(title: String?,
              message: String?,
              actions: UIAlertAction...) {
        
        show(title: title,
             message: message,
             style: Configuration.Alert.style,
             completion: nil,
             actions: actions)
    }
    
    func show(title: String?,
              message: String?,
              style: UIAlertControllerStyle,
              actions: [UIAlertAction]) {
        
        show(title: title,
             message: message,
             style: style,
             completion: nil,
             actions: actions)
    }
    
    func show(title: String?,
              message: String?,
              style: UIAlertControllerStyle = Configuration.Alert.style,
              completion: Empty?,
              actions: [UIAlertAction]) {
        
        DispatchQueue.toMain {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: style)
            for item in actions {
                alert.addAction(item)
            }
            
            self.show(alert: alert, completion)
        }
    }
    
    func show(alert: UIAlertController, _ completion: Empty? = nil) {
        DispatchQueue.toMain {
            self.present(alert, animated: true, completion: completion)
        }
    }
}
