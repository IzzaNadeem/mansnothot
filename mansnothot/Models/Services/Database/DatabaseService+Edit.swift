//
//  DatabaseService+Edit.swift
//  mansnothot
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension DatabaseService {
    //for editing posts/comments
    public func editPost(withPostID postID: String, newPost newPost: Post, newImage: UIImage?) {
        let ref = postsRef.child(postID)
        
        ref.updateChildValues(["category": newPost.category,
                      "title": newPost.title,
                      "bodyText": newPost.bodyText ?? ""
        ]) { (error, _) in
            if let error = error {
                self.delegate?.didFailEditingPost?(self, error: error.localizedDescription)
            } else if let image = newImage {
                StorageService.manager.storePostImage(image: image, withPostID: postID, completion: { (errorMessage) in
                    if let errorMessage = errorMessage {
                        self.delegate?.didFailEditingPost?(self, error: errorMessage)
                    } else {
                        self.delegate?.didEditPost?(self)
                    }
                })
            } else {
                self.delegate?.didEditPost?(self)
            }
        }
    }
    
    //needs to incorporate transactions for all of these!
        //should have updating flags
        //should have updating likes/dislikes
    //ban users
    
}
