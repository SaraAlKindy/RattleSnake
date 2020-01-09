//
//  ViewController.swift
//  RattleSnake
//
//  Created by Sara Al-Kindy on 11/01/2019.
//  Copyright (c) 2019 Sara Al-Kindy. All rights reserved.
//

import UIKit
import RattleSnake

class ViewController: UIViewController {
    //

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //signUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn() {
        RSMessenger.signIn(appName: "rattlesnake", userID: "0007", email: "user7@testchat.com") { result in
            switch result {
            case .success(_): print("logged in")
            case .failure(let error): print(error)
            }
        }
    }
    
    func updateUserMetaData(username: String) {
        RSMessenger.updateChatUserMeta(username: username, photoUrl: nil) { result in
            switch result {
                case .success(_): print("success login")
                case .failure(let error): print(error)
            }
        }
    }
    
    @IBAction func showConvos() {
        if let vc = RSMessenger.getAllConversations() as? RSPrivateConversationViewController{
            vc.openContactsHandler = {
                self.performSegue(withIdentifier: "openContacts", sender: self)
            }
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonTapped() {
        
    }
    
    //Function only used once to create users for testing
    func signUp() {
        RSMessenger.signUp(appName: "rattlesnake", userID: "0006", email: "user5@testchat.com") { result in
            switch result {
            case .success(_):
                print("created User 6")
                self.updateUserMetaData(username: "user6")
            case .failure(let error): print(error)
            }
        }
        
        RSMessenger.signUp(appName: "rattlesnake", userID: "0007", email: "user7@testchat.com") { result in
            switch result {
            case .success(_):
                print("created User 7")
                self.updateUserMetaData(username: "user7")
            case .failure(let error): print(error)
            }
        }
    }
}

