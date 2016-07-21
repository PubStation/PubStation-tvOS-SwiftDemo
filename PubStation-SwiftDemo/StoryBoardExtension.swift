//
//  StoryBoardExtension.swift
//  PubStation-SwiftDemo
//
//  Copyright © 2016 PubStation. All rights reserved.
//

import Foundation

extension UIStoryboard {
    
    class func viewControllerFromStoryboard(name : String, id: String) -> UIViewController {
        let viewController:UIViewController = UIStoryboard(name: name, bundle: nil).instantiateViewControllerWithIdentifier(id)
        return viewController
    }
    
}
