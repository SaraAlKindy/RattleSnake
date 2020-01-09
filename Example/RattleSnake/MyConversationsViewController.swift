//
//  MyConversationsViewController.swift
//  RattleSnake_Example
//
//  Created by Sara Al-Kindy on 2019-11-08.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import RattleSnake

class MyConversationsViewController: RSPrivateConversationViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem?.tintColor = .orange
    }
}
