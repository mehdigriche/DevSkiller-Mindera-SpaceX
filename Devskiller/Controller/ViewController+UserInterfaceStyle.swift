//
//  ViewController+UserInterfaceStyle.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateInterfaceStyle()
        }
    }
    
    func updateInterfaceStyle() {
        if traitCollection.userInterfaceStyle == .dark {
            // check if there is a view not changing its color auto in dark mode
            darkLightModeButton.image = UIImage(systemName: "sun.max.fill")
            let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = titleAttributes
        } else {
            // check if there is a view not changing its color auto in light mode
            darkLightModeButton.image = UIImage(systemName: "moon")
            let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = titleAttributes
        }
    }
    
    func toggleDarkLightMode() {
        if traitCollection.userInterfaceStyle == .dark {
            overrideUserInterfaceStyle = .light
        } else {
            overrideUserInterfaceStyle = .dark
        }
        // Update the interface style immediately
        updateInterfaceStyle()
    }
}
