//
//  ViewControllerExtension.swift
//  PubStation-SwiftDemo
//
//  Copyright © 2016 PubStation. All rights reserved.
//

import Foundation

extension UIViewController {
    public class var identifier : String {
        var name = NSStringFromClass(self)
        name = name.componentsSeparatedByString(".").last!
        return name
    }
}