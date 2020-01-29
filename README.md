# RattleSnake

[![Build Status](https://gitlab.com/gitlab-com/doc-gitlab-com/badges/master/build.svg)](https://repo.riavera.com/libraries/ios/rattlesnake/tree/master)
[![Swift5.0](https://img.shields.io/badge/Swift-5.0-blue.svg?style=flat)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)
[![Platform](https://img.shields.io/cocoapods/p/RattleSnake.svg?style=flat)](https://developer.apple.com/iphone/index.action)

A Wrapper for ChatSDK with Firebase

## Installation

RattleSnake is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RattleSnake'
```

## Requirements

`Swift 5`, `iOS 12`

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

You will have to setup a Firebase project and add the configurations to the project in order to run the example.

## Setup

[ChatSDK](https://chatsdk.co/) is an open source mobile chat framwork for Firebase and XMPP. RattleSnake currently supports [Firebase](https://github.com/chat-sdk/chat-sdk-ios) only.

Follow the [instructions](https://github.com/chat-sdk/chat-sdk-ios#firebase-setup) to generate the ```GoogleService-Info.plist``` to your project and to configure the project on the Firebase console. 

Copy the ```chat_sdk``` row from the RattleSnake Example project's Info.plist to your project's Info.plist. Make sure to setup the keys according to the configuration for your project.

## Messenger

Initialize ```RSChatConfigurator``` in your ```AppDelegate``` as follows:

```swift
let textChat = RSChatConfigurator.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        textChat.initialize(application: application, launchOptions: launchOptions, rootPath: "myDatabase", interfaceAdapter: MyInterfaceAdapter())
        return true
    }
```
```rootPath``` refers to the highest path in your database. ```interfaceAdapter``` refers to an adapter for your interface should. It is explained below. If you would like to use the default interface then leave this argument out. 

Use ```RSMessenger``` to perform messenger functionalities:

```swift
RSMessenger.signIn(appName: "rattlesnake", userID: "0007", email: "user7@testchat.com") { result in
            switch result {
            case .success(_): print("logged in")
            case .failure(let error): print(error)
            }
        }
        
RSMessenger.updateChatUserMeta(username: username, photoUrl: nil) { result in
            switch result {
                case .success(_): print("success login")
                case .failure(let error): print(error)
            }
        }
```

## Interface

There are three interfaces available in ```RattleSnake```:

*  ```RSContactsViewController```: Display the current user's contact list
*  ```RSPrivateConversationViewController```: Display all the chats the user is currently engaged in.
*  ```RSChatViewController```: Display the conversation thread between the current user and another user

With ```RSPrivateConversationViewController``` you will need to define functionality for when the user wants to start a new converstaion via the ```openContactsHandler``` closure

```swift
 if let vc = RSMessenger.getAllConversations() as? RSPrivateConversationViewController{
            vc.openContactsHandler = {
                self.performSegue(withIdentifier: "openContacts", sender: self)
            }
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true, completion: nil)
        }
```

You can customize the interface by subclassing the view controller then defining your own ```RSChatInterfaceAdapter``` at initilization

```swift
class MyConversationsViewController: RSPrivateConversationViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem?.tintColor = .orange
    }
}
```

```swift
class MyInterfaceAdapter: RSInterfaceAdapter {
    
    override func privateThreadsViewController() -> UIViewController! {
        
        return MyConversationsViewController()
    }
}
```

```swift
textChat.initialize(application: application, launchOptions: launchOptions, rootPath: "myDatabase", interfaceAdapter: MyInterfaceAdapter())
```

## ToDo

*  Make ```RSChatConfiguration``` more configurable
*  Interface customization with bubble chat colors
*  Interface customization with background images

## Author

Sara Al-Kindy, salkindy@riavera.com

## License

RattleSnake is available under the MIT license. See the LICENSE file for more info.
