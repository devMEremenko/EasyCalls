/*
 Copyright (c) 2018 Maxim Eremenko <devmeremenko@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/

import UIKit

public typealias TextFieldAction = (UITextField) -> ()

public extension UIViewController {
    
    func show(message: String?, actions: UIAlertAction...) {
        
        show(title: nil,
             message: message,
             style: Configuration.Alert.style,
             completion: nil,
             textFields: nil,
             actions: actions)
    }
    
    func show(title: String?,
              style: UIAlertControllerStyle,
              actions: UIAlertAction...) {
        
        show(title: title,
             message: nil,
             style: Configuration.Alert.style,
             completion: nil,
             textFields: nil,
             actions: actions)
    }
    
    func show(title: String?, actions: UIAlertAction...) {
        
        show(title: title,
             message: nil,
             style: Configuration.Alert.style,
             completion: nil,
             textFields: nil,
             actions: actions)
    }
    
    func show(title: String?,
              message: String?,
              actions: UIAlertAction...) {
        
        show(title: title,
             message: message,
             style: Configuration.Alert.style,
             completion: nil,
             textFields: nil,
             actions: actions)
    }
    
    func show(title: String?,
              message: String?,
              textFields: [TextFieldAction],
              actions: UIAlertAction...) {
        
        show(title: title,
             message: message,
             style: Configuration.Alert.style,
             completion: nil,
             textFields: textFields,
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
             textFields: nil,
             actions: actions)
    }
    
    func show(title: String?,
              message: String?,
              style: UIAlertControllerStyle = Configuration.Alert.style,
              completion: Empty?,
              textFields: [TextFieldAction]? = nil,
              actions: [UIAlertAction]) {
        
        DispatchQueue.toMain {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: style)
            
            if let fields = textFields {
                for item in fields {
                    alert.addTextField(configurationHandler: item)
                }
            }
            
            for item in actions {
                item.handler = alert
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
