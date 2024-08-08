//
//  ContentView.swift
//  CombineProject
//
//  Created by Consultant on 7/31/23.
//

import SwiftUI
import Combine

struct PlanetView: View {
    
    @StateObject var userViewModel = UserViewModel(networkManager: NetworkManager())
    @State private var searchText = ""
    var body: some View {
        NavigationStack{
            VStack(spacing:20) {
                Button("Cancel"){
                    userViewModel.cancelAPICall()
                }
                List(userViewModel.filteredresult){ value in
                    VStack(alignment: .leading,spacing:10){
                        Text(value.name)
                        Text(value.population)
                        Text(value.rotationPeriod)
                        Text(value.orbitalPeriod)
                    }
                    
                }
            }.task{
                userViewModel.getProductsFromAPI(urlString: API.UserAPI)
            }
            .searchable(text: $searchText, prompt: "Search Your Note")
            .onChange(of: searchText) { newValue in
                userViewModel.filterresult(searchText: newValue)
            }
            
        }
    }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetView()
    }
}
