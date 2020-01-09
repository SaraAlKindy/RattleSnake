//
//  TestViewController.swift
//  RattleSnake_Example
//
//  Created by Sara Al-Kindy on 2019-11-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import RattleSnake

class TestViewController: UIViewController {
    
    @IBAction func showConversation() {
        let username = "User2"
        RSMessenger.startConversation(username: username) { result in
            switch result {
            case .success(let vc): self.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
