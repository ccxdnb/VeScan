//
//  Array+Utils.swift
//  VeScan
//
//  Created by Joaquin Wilson on 19-06-24.
//

import SwiftUI

extension Array<UnitPoint> {
    func rotateLeftByOne() -> [UnitPoint] {
        guard !self.isEmpty else { return self }
        var rotatedArray = self
        let lastElement = rotatedArray.removeLast()
        rotatedArray.insert(lastElement, at: 0)
        return rotatedArray
    }
}
extension Array<Color> {
    func rotateLeftByOne() -> [Color] {
        guard !self.isEmpty else { return self }
        var rotatedArray = self
        let lastElement = rotatedArray.removeLast()
        rotatedArray.insert(lastElement, at: 0)
        return rotatedArray
    }
}
