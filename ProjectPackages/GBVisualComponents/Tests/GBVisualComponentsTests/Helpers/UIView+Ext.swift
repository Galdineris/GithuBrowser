//
//  UIView+Ext.swift
//  
//
//  Created by Rafael Galdino on 12/03/22.
//

import Foundation
import UIKit

extension UIView {
    func viewWith(accessibilityIdentifier identifier: String) -> UIView? {
        if self.accessibilityIdentifier == identifier {
            return self
        }
        var result: UIView? = nil
        for subView in subviews {
            if let match = subView.viewWith(accessibilityIdentifier: identifier) {
                result = match
                break
            }
        }
        return result
    }
}
