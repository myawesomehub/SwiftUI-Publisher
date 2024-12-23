//
//  HomeView.swift
//  Swifly
//
//  Created by Mohammad Yasir on 23/12/24.
//

import SwiftUI
import at_myawesomehub

struct HomeView: View {
    @State private var searchedText: String = ""
    
    init() { }
    
    var body: some View {
        NavigationStack {
            List(searchedText.isEmpty ? developers : developers.filter { $0.name.localizedStandardContains(searchedText) }, id: \.id) { dev in
                NavigationLink {
                    DeveloperDetailView(with: dev.designs)
                } label: {
                    Text(dev.name)
                }

            }
            .listStyle(.plain)
            .navigationTitle("Developers")
            .searchable(text: $searchedText, prompt: "Serach for developer")
        }
    }
}

#Preview {
    HomeView()
}
