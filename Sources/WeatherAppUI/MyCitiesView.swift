//
//  MyCitiesView.swift
//  
//
//  Created by Loic D on 15/03/2023.
//

import SwiftUI
import WeatherAppComposant

public struct WeatherApp: View {
    private let apiKey: String
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public var body: some View {
        MyCitiesView()
            .environmentObject(CitiesWeatherViewModel(apiKey: apiKey))
    }
}

struct MyCitiesView: View {
    var body: some View {
        VStack {
            MyCitiesTopBar()
            
            MyCitiesList().scrollableVStack().background(Color("BackgroundColor", bundle: Bundle.module))
        }
    }
    
    struct MyCitiesTopBar: View {
        @EnvironmentObject var cityWeatherVM: CitiesWeatherViewModel
        @State private var showingNewCitySheet = false
        
        var body: some View {
            HStack {
                Text("Mes villes")
                    .title()
                Spacer()
                Button(action: {
                    showingNewCitySheet = true
                }, label: {
                    Text("+")
                        .buttonLabel()
                })
            }.padding()
            .sheet(isPresented: $showingNewCitySheet) {
                NewCitySheet(citySearchViewModel: cityWeatherVM.citySearchVM)
            }
        }
    }
    
    struct MyCitiesList: View {
        @EnvironmentObject var cityWeatherVM: CitiesWeatherViewModel
        
        var body: some View {
            VStack {
                ForEach(cityWeatherVM.cities) { city in
                    CitiesListElement(city: city)
                }
                Spacer()
            }
        }
        
        struct CitiesListElement: View {
            @State private var showingCityDetailsSheet = false
            @ObservedObject var city: CityWeather
            
            var body: some View {
                Button(action: {
                    showingCityDetailsSheet = true
                }, label:  {
                    HStack {
                        Text(city.name)
                            .subtitle()
                        Spacer()
                        if city.weather != nil {
                            Text(city.weather!.currentTemp)
                                .subtitle()
                        }

                    }
                }).padding().disabled(city.weather == nil).background(Color(UIColor.systemBackground).cornerRadius(10).shadowed()).padding(5)
                .sheet(isPresented: $showingCityDetailsSheet) {
                    CityDetailsSheet(city: city)
                }
            }
        }
    }
}
