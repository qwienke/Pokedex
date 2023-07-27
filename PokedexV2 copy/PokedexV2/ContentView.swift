//
//  ContentView.swift
//  PokedexV2
//
//  Created by Quinn Wienke on 7/25/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchBarSearchText = ""
    
    var body: some View {
        NavigationStack {
            Text("searching for \(searchBarSearchText)")
                .navigationTitle("Pokédex")
        }
        .searchable(text: $searchBarSearchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
