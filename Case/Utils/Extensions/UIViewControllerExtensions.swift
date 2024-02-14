//
//  UIViewControllerExtensions.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import Foundation
import UIKit

extension UIViewController {
    
    var shouldHideKeyboardOnTap: Bool {
        get {
            if let gestures = view.gestureRecognizers {
                for gesture in gestures {
                    if gesture is UITapGestureRecognizer {
                        return true
                    }else {
                        return false
                    }
                }
            }
            return false
        }
        set {
            if newValue && !shouldHideKeyboardOnTap {
                let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
                tap.cancelsTouchesInView = false
                view.addGestureRecognizer(tap)
            }else {
                if let gestures = view.gestureRecognizers {
                    for gesture in gestures {
                        if let recognizer = gesture as? UITapGestureRecognizer {
                            view.removeGestureRecognizer(recognizer)
                        }
                    }
                }
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default, handler: nil)]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for action in actions {
            alertController.addAction(action)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.color = .white
        loadingIndicator.style = .large
        loadingIndicator.tag = 9876
        loadingIndicator.center = view.center
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
    }
    
    func hideLoadingIndicator() {
        if let loadingIndicator = view.subviews.first(where: { $0.tag == 9876 }) as? UIActivityIndicatorView {
            loadingIndicator.stopAnimating()
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func add(_ child: UIViewController, withFrame frame: CGRect? = nil) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = frame ?? view.bounds
        child.didMove(toParent: self)
    }
    
    func remove(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
