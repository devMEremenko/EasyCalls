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

public struct Configuration {
    
    public static var ok: String = "OK"
    public static var cancel: String = "Cancel"
    
    public struct Action {
        public static var defaultStyle = UIAlertActionStyle.default
        public static var cancelStyle = UIAlertActionStyle.cancel
    }
    
    public struct Alert {
        public static var style = UIAlertControllerStyle.alert
    }
}

public class Action {
    
    public typealias ActionHandler = (UIAlertAction) -> Void
    
    public static var ok: UIAlertAction {
        return UIAlertAction(title: Configuration.ok, style: .default, handler: nil)
    }
    
    public static func ok(_ handler: @escaping ActionHandler) -> UIAlertAction {
        return UIAlertAction(title: Configuration.ok, style: .default, handler: handler)
    }
    
    public static var cancel: UIAlertAction {
        let style = Configuration.Action.cancelStyle
        return UIAlertAction(title: Configuration.cancel, style: style, handler: nil)
    }
    
    public static func cancel(_ handler: @escaping ActionHandler) -> UIAlertAction {
        let style = Configuration.Action.cancelStyle
        return UIAlertAction(title: Configuration.cancel, style: style, handler: handler)
    }
    
    public static func with(title: String? = nil,
                     style: UIAlertActionStyle = Configuration.Action.defaultStyle,
                     _ handler: @escaping ActionHandler) -> UIAlertAction {
        
        return UIAlertAction(title: title, style: style, handler: handler)
    }
    
    public static func field(_ action : @escaping TextFieldAction) -> TextFieldAction {
        return action
    }
}
