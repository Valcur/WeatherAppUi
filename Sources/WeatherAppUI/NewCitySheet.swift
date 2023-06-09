//
//  NewCitySheet.swift
//  
//
//  Created by Loic D on 15/03/2023.
//

import SwiftUI
import WeatherAppComposant

struct NewCitySheet: View {
    @ObservedObject var citySearchViewModel: CitySearchViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $citySearchViewModel.searchQuery)
                List(citySearchViewModel.completions) { completion in
                    Button {
                        citySearchViewModel.addPlace(place: completion)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        VStack(alignment: .leading) {
                            Text(completion.title)
                            Text(completion.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }.navigationBarTitle(Text("Ajouter une ville"))
            }
        }
    }
    
    struct SearchBar: UIViewRepresentable {

        @Binding var text: String

        class Coordinator: NSObject, UISearchBarDelegate {
            
            @Binding var text: String
            
            init(text: Binding<String>) {
                _text = text
            }

            func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                text = searchText
            }
        }

        func makeCoordinator() -> SearchBar.Coordinator {
            return Coordinator(text: $text)
        }

        func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
            let searchBar = UISearchBar(frame: .zero)
            searchBar.delegate = context.coordinator
            searchBar.searchBarStyle = .minimal
            return searchBar
        }

        func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
            uiView.text = text
        }
    }
}
