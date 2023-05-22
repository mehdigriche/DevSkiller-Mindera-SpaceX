//
//  ViewController+Alert.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    func showAlert(launch: Launch) {
        let alertController = UIAlertController(title: "Select an option", message: nil, preferredStyle: .actionSheet)
        let articleButton = UIAlertAction(title: "Article", style: .default) { _ in
            Constants().openLinkInBrowser(url: launch.links?.article ?? "")
        }
        
        let wikipediaButton = UIAlertAction(title: "Wikipedia", style: .default) { _ in
            Constants().openLinkInBrowser(url: launch.links?.wikipedia ?? "")
        }
        
        let videoButton = UIAlertAction(title: "Video", style: .default) { _ in
            Constants().openLinkInBrowser(url: launch.links?.webcast ?? "")
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(articleButton)
        alertController.addAction(wikipediaButton)
        alertController.addAction(videoButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
    }
}
