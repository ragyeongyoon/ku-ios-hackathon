//
//  Post.swift
//  PlantingShare
//
//  Created by 김준오 on 23/08/2019.
//  Copyright © 2019 lim. All rights reserved.
//

import UIKit

class Post: NSObject, Codable {
    
    var name: String?
    var date: Date?
//    var postImage: UIImage? // file 경로를 저장한다.
    var postContent: String?
    
}
