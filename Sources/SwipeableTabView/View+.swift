//
//  File.swift
//  
//
//  Created by Kazumasa Wakamori on 2022/09/13.
//

import SwiftUI

extension View {
    var isEmptyView: Bool {
        
        let mirror = Mirror(reflecting: self)
        
        if mirror.subjectType == EmptyView.self {
            return true
        }

        if let range = mirror.descendant("data") as? CountableRange<Int>, range.isEmpty {
            return true
        }

        if let array = mirror.descendant("data") as? [Any], array.isEmpty {
            return true
        }
        
        return false

    }
}
