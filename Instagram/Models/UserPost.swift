//
//  PhotoPost.swift
//  Instagram
//
//  Created by Roy Park on 3/10/21.
//

import UIKit

public enum UserPostType {
    case photo, video
}


/// representing user post information
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // either video url or full resolution photo
    let caption: String? // user might provide the caption
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUser: [String]
}

enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

struct PostLike { // to see who has liked the post
    let username: String
    let postIdentifier: String
}

struct CommentLike { // to see who has liked the post
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}
