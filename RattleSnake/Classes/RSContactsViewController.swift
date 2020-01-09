//
//  RSContactsViewController.swift
//  RattleSnake
//
//  Created by Sara Al-Kindy on 2019-11-01.
//

import Foundation
import ChatSDK

open class RSContactsViewController: BContactsViewController {
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = closeButton
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
