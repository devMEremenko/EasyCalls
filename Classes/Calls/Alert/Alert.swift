//
//  Alert.swift
//  EasyCalls
//
//  Created by Maxim Eremenko on 3/13/18.
//  Copyright © Maxim Eremenko. All rights reserved.
//

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
}
