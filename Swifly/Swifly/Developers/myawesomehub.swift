//
//  myawesomehub.swift
//  Swifly
//
//  Created by Mohammad Yasir on 24/12/24.
//

import Foundation

var developers: [Developer] = [
    myawesomehub
]

import at_myawesomehub
let myawesomehub = Developer(
    name: "Mohammad Yasir",
    gitHubHandle: "myawesomehub",
    designs: [
        .init(
            title: "Star Travelling",
            description: "A animation which demonstrate many stars travelling towards centre of the screen.",
            destination: StarAnimation().eraseToAnyView()
        ),
        .init(
            title: "Loader Animation",
            description: "A loader from 0 to 100.",
            destination: LoaderAnimation().eraseToAnyView()
        )
    ]
)
