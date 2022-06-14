//
//  UI.swift
//  Ray-Wanderlich
//
//  Created by Ambuj Punn on 6/14/22.
//

import Foundation
import UIKit

extension UIViewController: Serviceable { }

/// Creates an adapter to wrap a UIViewController inside in order to dependency inject a required service
struct ServiceAdapter<T: UIViewController> {
    let viewController: T
    
    init<S: Service>(service: S) {
        viewController = T()
        viewController.setService(service)
    }
}
