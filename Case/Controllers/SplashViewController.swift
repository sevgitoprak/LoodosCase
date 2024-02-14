//
//  SplashViewController.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import UIKit
import FirebaseRemoteConfig

final class SplashViewController: UIViewController {
    
    // MARK: - UI Properties
    @IBOutlet private weak var lblGreeting: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblGreeting.text = RemoteConfigManager.value(forKey: .splashText)
        animateLogo()
        
        if InternetConnectionManager.shared.isInternetAccessible() {
            showAlert(title: "Hata", message: "İnternet bağlantısı bulunamadı. Lütfen internet bağlantınızı kontrol edin.")
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
                self?.performSegue(withIdentifier: "toHome", sender: nil)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func animateLogo() {
        var originalFrame = lblGreeting.frame
        originalFrame.origin.y -= 50
        let finalFrame = lblGreeting.frame
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.lblGreeting.frame = originalFrame
        }, completion: { _ in
            self.lblGreeting.frame = finalFrame
        })
    }
    
}
