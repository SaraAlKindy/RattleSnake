//
//  RSMessenger.swift
//  Pods-RattleSnake_Example
//
//  Created by Sara Al-Kindy on 2019-11-01.
//

import Foundation
import ChatSDK

public enum BlockResultStatus<T> {
    case success(T)
    case failure(Error)
}

public typealias BlockCallBack<T> = (BlockResultStatus<T>) -> Void

public class RSMessenger {
    public class func signUp(appName: String, userID: String, email: String, completion: @escaping BlockCallBack<Bool>) {
        let password = String(decoding: (userID + appName).MD5(), as: UTF8.self)
        let block = BChatSDK.auth()?.authenticate(BAccountDetails.signUp(email, password: password))?.thenOnMain
        _ = block?( { (result: Any?) -> Any? in
            completion(.success(true))
        }, { (error: Error?) -> Any? in
            completion(.failure(RSError.Failure(reason: error?.localizedDescription ?? "An error has occured")))
        })
    }
    
    public class func signIn(appName: String, userID: String, email: String, completion: @escaping BlockCallBack<Bool>) {
        let password = String(decoding: (userID + appName).MD5(), as: UTF8.self)
        let block = BChatSDK.auth()?.authenticate(BAccountDetails.username(email, password: password))?.thenOnMain
        _ = block?( { (result: Any?) -> Any? in
            completion(.success(true))
        }, { (error: Error?) -> Any? in
            completion(.failure(RSError.Failure(reason: error?.localizedDescription ?? "An error has occured")))
        })
    }
    
    public class func signOut() {
        BChatSDK.auth()?.logout()
    }
    
    public class func updateChatUserMeta(username: String? = nil, photoUrl: String? = nil, completion: (BlockCallBack<Bool>)?) {
        
        if username == nil && photoUrl == nil {
            completion?(.failure(RSError.Failure(reason: "Did not provide a username or photo url to update metadata")))
        }
        
        if let user = BChatSDK.currentUser() {
            if let username = username {
                user.setMetaValue(username, forKey: "name")
                user.setMetaValue(username.lowercased(), forKey: "name-lowercase")
                user.setName(username)
            }
            
            if let photoUrl = photoUrl {
                user.setMetaValue(photoUrl, forKey: "pictureURL")
            }
    
            let block = BChatSDK.core()?.pushUser()?.thenOnMain
            _ = block?( { (result: Any?) -> Any? in
                completion?(.success(true))
            }, { (error: Error?) -> Any? in
                completion?(.failure(RSError.Failure(reason: error?.localizedDescription ?? "An error occured")))
            })
            
        } else {
            completion?(.failure(RSError.Failure(reason: "There is no user signed in")))
        }
    }
    
    public class func block(username: String, completion: @escaping BlockCallBack<Bool>) {
        searchForContact(username: username) { (result) in
            switch result {
            case .success(let user):
                BChatSDK.blocking()?.blockUser(user.entityID())
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public class func unblock(username: String, completion: @escaping BlockCallBack<Bool>) {
        searchForContact(username: username) { (result) in
            switch result {
            case .success(let user):
                BChatSDK.blocking()?.unblockUser(user.entityID())
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public class func getAllConversations() -> UIViewController? {
       return BChatSDK.ui()?.privateThreadsViewController()
    }
    
    public class func startConversation(username: String, completion: @escaping BlockCallBack<UIViewController>) {
        //User already in contact
        if let user = getContact(username: username) {
            getConversationThread(user: user) { result in
                switch result {
                case .success(let vc):
                    completion(.success(vc))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            //User not in contact, add then start convo
            searchForContact(username: username) { result in
                switch result {
                case .success(let user):
                    getConversationThread(user: user) { result in
                        switch result {
                        case .success(let vc):
                            completion(.success(vc))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
 
    public class func isUserContact(username: String) -> Bool {
        if getContact(username: username) != nil { return true }
        return false
    }
    
    public class func getUnreadMessagesCount() -> Int {
        return Int(BChatSDK.currentUser()?.unreadMessageCount() ?? 0)
    }
    
    //MARK: - Private class Functions
    
    private class func getContact(username: String) -> PUser? {
        guard let contacts = getAllContacts() else {
            return nil
        }
        
        for user in contacts {
            if user.name() == username {
                return user
            }
        }
        
        return nil
    }
    
    private class func getAllContacts() -> [PUser]? {
        if let contacts = BChatSDK.currentUser()?.contacts(with: bUserConnectionTypeContact) as? [PUser] {
            return contacts
        }
        
        return nil
    }
    
    fileprivate static var didFindContact = false
    
    private class func searchForContact(username: String, completion: @escaping BlockCallBack<PUser>) {
        self.didFindContact = false
        BChatSDK.search()!.users(forIndexes: ["name-lowercase"], withValue: username.lowercased(), limit: 1, userAdded: { user in
            print("Firebase - BChatSDK search")
            if let user = user {
                self.didFindContact = true
                completion(.success(user))
            } else {
                completion(.failure(RSError.Failure(reason: "Could not find the user")))
            }
            })!.thenOnMain( { (result: Any?) -> Any? in
                if self.didFindContact == false {
                    completion(.failure(RSError.Failure(reason: "Could not find contact")))
                }
                return nil
            }, { (error: Error?) -> Any? in
                completion(.failure(RSError.Failure(reason: error?.localizedDescription ?? "Uknown error")))
                return nil
            })
    }
    
    private class func getConversationThread(user: PUser, completion: @escaping BlockCallBack<UIViewController>) {
        if let thread = BChatSDK.core()?.fetchThread(withUsers: [BChatSDK.currentUser()!, user]) {
            if let vc = BChatSDK.ui()?.chatViewController(with: thread) {
                completion(.success(vc))
            } else {
                completion(.failure(RSError.Failure(reason: "Could not create the chat VC")))
            }
        } else {
            BChatSDK.core()?.createThread(withUsers: [BChatSDK.currentUser()!, user], threadCreated: { (error, thread) in
                self.addContact(user: user)
                if let thread = thread {
                    if let vc = BChatSDK.ui()?.chatViewController(with: thread) {
                        completion(.success(vc))
                    } else {
                        completion(.failure(RSError.Failure(reason: "Could not create the chat VC")))
                    }
                } else {
                    completion(.failure(RSError.Failure(reason: "Could not find user")))
                }
            })
        }
    }
    
    private class func addContact(user: PUser) {
        let block = BChatSDK.contact()?.addContact(user, with: bUserConnectionTypeContact)?.thenOnMain
        _ = block!( { (result: Any?) -> Any? in
            print(result)
            return nil
        }, { (error: Error?) -> Any? in
            print(error)
            return nil
        })
    }
}

//BChatSDK.shared()?.pushQueue()?.popFirst()
