//
//  CurrentUser.swift
//  SnapchatClonePt3
//
//  Created by SAMEER SURESH on 3/19/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class CurrentUser {
    
    var username: String!
    var id: String!
    var readPostIDs: [String]?
    
    let dbRef = FIRDatabase.database().reference()
    
    init() {
        let currentUser = FIRAuth.auth()?.currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
    }
    
    /*
        TODO:
        
        Retrieve a list of post ID's that the user has already opened and return them as an array of strings.
        Note that our database is set up to store a set of ID's under the readPosts node for each user.
        Make a query to Firebase using the 'observeSingleEvent' function (with 'of' parameter set to .value) and retrieve the snapshot that is returned. If the snapshot exists, store its value as a [String:AnyObject] dictionary and iterate through its keys, appending the value corresponding to that key to postArray each time. Finally, call completion(postArray).
    */
    var i = Int()
    func getReadPostIDs(completion: @escaping ([String]) -> Void) {
        var postArray: [String] = []
        // TODO
       // postArray = readPostIDs!
        
        //FIRAuth.auth()?.currentUser.

        dbRef.child(firUsersNode).child(self.id).child(firReadPostsNode).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            self.i = 0
            if snapshot.exists() {
            let value = snapshot.value as? [String:AnyObject]
            
            //let username = value?["username"] as? String ?? ""
            postArray = []
            for (keys, values) in value! {
                
                postArray.append(values as! String)
               // self.i = self.i + 1
            }
            completion(postArray)
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        completion(postArray)
        
    }
    
    /*
        TODO:
     
        Adds a new post ID to the list of post ID's under the user's readPosts node.
        This should be fairly simple - just create a new child by auto ID under the readPosts node and set its value to the postID (string).
        Remember to be very careful about following the structure of the User node before writing any data!
     
     
    */
    func addNewReadPost(postID: String) {
        // TODO
        let newChild = dbRef.child(firUsersNode).child(self.id).child(firReadPostsNode).childByAutoId()
        newChild.setValue(postID)
        
        
    }
    
}
