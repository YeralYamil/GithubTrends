//
//  UIImageView.swift
//  GithubTrends
//
//  Created by Yeral Yamil on 8/19/18.
//  Copyright © 2018 yyamil. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func circular() {
        self.layer.borderWidth = 0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
