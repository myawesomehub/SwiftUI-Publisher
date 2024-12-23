//
//  Model.swift
//  Swifly
//
//  Created by Mohammad Yasir on 24/12/24.
//

import SwiftUI

struct Developer: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var gitHubHandle: String
    var designs: [Design]
}

struct Design: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var destination: AnyView
}
