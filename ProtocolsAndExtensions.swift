//
//  ProtocolsAndExtensions.swift
//  Calculator4FollowingLectureWithListOfTODOs
//
//  Created by justin on 15/08/2016.
//  Copyright © 2016 justin. All rights reserved.
//

import UIKit

protocol GraphViewDataSource {
    func calculateYGivenX(valueX x: CGFloat) -> CGFloat
}

extension CGPoint {
    mutating func offsetBy(xDirection: CGFloat, yDirection: CGFloat){
        self.x += xDirection
        self.y += yDirection
    }
}