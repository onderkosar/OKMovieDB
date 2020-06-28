//
//  UIViewController+Ext.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 5.06.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentOKAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = OKAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemOrange
        present(safariVC, animated: true)
    } 
}

