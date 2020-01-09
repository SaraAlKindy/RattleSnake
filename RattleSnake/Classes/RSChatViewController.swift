//
//  RSChatViewController.swift
//  RattleSnake
//
//  Created by Sara Al-Kindy on 2019-11-01.
//

import Foundation
import ChatSDK

open class RSChatViewController: BChatViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        backButton()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    public override func navigationBarTapped() {
        
    }
    
    public override func setSubtitle(_ subtitle: String!) {
        
    }
    
    func backButton() {
        self.view.endEditing(true)
        let barButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissSelf))
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
}
