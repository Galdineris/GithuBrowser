//
//  UINavigationController.swift
//  
//
//  Created by Rafael Galdino on 04/04/22.
//

import Foundation
import UIKit

final class UINavigationControllerMock: UINavigationController {
    private(set) var pushedViewControllers: [UIViewController] = []
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
    }
}
