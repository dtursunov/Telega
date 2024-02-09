//
//  UIViewController+Extension.swift
//  Telega
//
//  Created by Diyor Tursunov on 08/02/24.
//

import UIKit

extension UIViewController {
    public func addChildViewController(_ childController: UIViewController) {
        addChild(childController)
        view.addSubview(childController.view)
        childController.view.frame = view.bounds
        childController.didMove(toParent: self)
    }

    public func removeFromParentController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }

    public func removeAllChilds() {
        children.forEach { $0.removeFromParentController() }
    }
}
