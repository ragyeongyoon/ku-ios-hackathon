//
//  Contents.swift
//  PlantingShare
//
//  Created by cscoi025 on 2019. 8. 23..
//  Copyright © 2019년 lim. All rights reserved.
//

import UIKit

class PlantInfo: NSObject, Codable {
        static let shared: PlantInfo = PlantInfo()
    
    var postTitle: String?
    var postAuthor: String?
    var postContent: String?
    var postDate: String?
}
