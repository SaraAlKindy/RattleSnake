//
//  RSInterfaceAdapter.swift
//  RattleSnake
//
//  Created by Sara Al-Kindy on 2019-11-01.
//

import Foundation
import ChatSDK

open class RSInterfaceAdapter: BDefaultInterfaceAdapter {
    
    open override func privateThreadsViewController() -> UIViewController! {
        
        return RSPrivateConversationViewController()
    }
    
    open override func contactsViewController() -> UIViewController! {
        return RSContactsViewController()
    }

    open override func chatViewController(with thread: PThread!) -> UIViewController! {
        return RSChatViewController.init(thread: thread)
    }
    
}
