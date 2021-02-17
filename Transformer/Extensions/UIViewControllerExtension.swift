//
//  UIViewControllerExtension.swift
//  Transformer
//
//  Created by Siddharth kadian on 16/02/21.
//

import UIKit

public typealias EmptyCompletion = () -> Void

public extension UIViewController {

    /// This function sets an image as the background of the view controller
    func setBackgroundImage(_ image: UIImage = .appBackground) {
        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = image
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }

    /// This function can be used to show alrets in view controller
    func showAlert(title: String = "Error",
                   message: String = "Something went wrong",
                   completion: EmptyCompletion? = nil) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
        completion?()
      }))
      present(alert, animated: true, completion: nil)
    }
}
