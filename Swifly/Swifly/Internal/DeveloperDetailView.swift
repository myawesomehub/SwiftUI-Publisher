//
//  DeveloperDetailView.swift
//  Swifly
//
//  Created by Mohammad Yasir on 24/12/24.
//

import SwiftUI

struct DeveloperDetailView: View {
    @State private var searchedText: String = ""
    private let designs: [Design]
    
    init(with designs: [Design]) {
        self.designs = designs
    }
    
    var body: some View {
        List(searchedText.isEmpty ? designs : designs.filter { $0.title.localizedStandardContains(searchedText) }, id: \.id) { design in
            NavigationLink {
                design.destination
            } label: {
                Text(design.title)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Designs")
        .searchable(text: $searchedText, prompt: "Serach for design")
    }
}
