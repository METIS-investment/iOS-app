//
//  UIViewController+Toast.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import UIKit

extension UIViewController {
    func showToast(message: String, duration: CGFloat = 3.0) {
        let toastLabel = UILabel(
            frame: CGRect(
                x: view.frame.size.width / 2 - 75,
                y: view.frame.size.height - 100,
                width: 150,
                height: 30
            )
        )
        //   toastLabel.backgroundColor = .appTint
        //  toastLabel.textColor = .appWhite
        toastLabel.font = .appCaption
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        view.addSubview(toastLabel)

        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}
