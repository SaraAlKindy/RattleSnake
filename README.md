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

## Setup

[ChatSDK](https://chatsdk.co/) is an open source mobile chat framwork for Firebase and XMPP. RattleSnake currently supports [Firebase](https://github.com/chat-sdk/chat-sdk-ios) only.

Follow the [instructions](https://github.com/chat-sdk/chat-sdk-ios#firebase-setup) to generate the ```GoogleService-Info.plist``` to your project. 

Copy the ```chat_sdk``` row from the RattleSnake Example project's Info.plist to your project's Info.plist.

To run the example project and test it out,

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.



```swift
RSPrivateConversationViewController
```


## Author

Sara Al-Kindy, salkindy@riavera.com

## License

RattleSnake is available under the MIT license. See the LICENSE file for more info.
