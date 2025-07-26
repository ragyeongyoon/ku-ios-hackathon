//
//  DiarySecondViewUIBarButtonItem.swift
//  PlantingShare
//
//  Created by 김준오 on 26/08/2019.
//  Copyright © 2019 lim. All rights reserved.
//

import UIKit

class DiarySecondViewUIBarButtonItem: UIBarButtonItem {

}
extension DiarySecondViewUIBarButtonItem {
    var isHidden: Bool = false {
        didSet {
            isEnabled = !isHidden
            tintColor = isHidden ? UIColor.clear : UIColor.black
        }
    }
}
