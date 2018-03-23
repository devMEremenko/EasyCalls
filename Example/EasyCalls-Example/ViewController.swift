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
