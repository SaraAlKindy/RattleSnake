//
//  RSPrivateConversationViewController.swift
//  RattleSnake
//
//  Created by Sara Al-Kindy on 2019-11-01.
//

import Foundation
import ChatSDK

open class RSPrivateConversationViewController: BPrivateThreadsViewController {
    
    public var openContactsHandler: (() -> ())?
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openContacts))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func openContacts() {
        if let openContactsHandler = openContactsHandler {
            openContactsHandler()
        } else {
            print("RATTLESNAKE ERROR - Please set the completion handler for opening contacts")
        }
    }
}

//When user selects a user then we need to show the private chat, change the way it is done here
//extension RSPrivateConversationViewController: ChatUserSelectedProtocol {
//    func chatUserWasSelectedWithThread(thread: PThread, viewController: UIViewController) {
//        
//        viewController.dismiss(animated: true, completion: {
//            if let chatVc = BChatSDK.ui()?.chatViewController(with: thread) {
//                self.navigationController?.pushViewController(chatVc, animated: true)
//            }
//        })
//    }
//}
