//
//  ProfileModel.swift
//  LSLPBasic
//
//  Created by 박신영 on 5/1/25.
//

import Foundation

struct ProfileModel: Decodable {
    let userID, email, nick: String
    let followers, following, posts: [String]
    let phoneNum, profileImage, birthDay: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, nick, followers, following, posts, phoneNum, profileImage, birthDay
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userID = try container.decode(String.self, forKey: .userID)
        self.email = try container.decode(String.self, forKey: .email)
        self.nick = try container.decode(String.self, forKey: .nick)
        self.followers = try container.decode([String].self, forKey: .followers)
        self.following = try container.decode([String].self, forKey: .following)
        self.posts = try container.decode([String].self, forKey: .posts)
        self.phoneNum = try container.decodeIfPresent(String.self, forKey: .phoneNum) ?? "번호 미지정"
        self.profileImage = try container.decodeIfPresent(String.self, forKey: .profileImage) ?? "star.fill"
        self.birthDay = try container.decodeIfPresent(String.self, forKey: .birthDay) ?? "생년월일 미지정"
    }
}
