//
//  TableViewCellExtension.swift
//  PubStation-SwiftDemo
//
//  Copyright © 2016 PubStation. All rights reserved.
//

import Foundation

extension UITableViewCell {
    public class var identifier : String {
        var name = NSStringFromClass(self)
        name = name.componentsSeparatedByString(".").last!
        return name
    }
}