//
//  CityDetailsSheet.swift
//  
//
//  Created by Loic D on 15/03/2023.
//

import SwiftUI
import WeatherAppComposant

struct CityDetailsSheet: View {
    let city: CityWeather
    var weather: WeatherData {
        if city.weather == nil {
            return WeatherData.noWeather
        }
        return city.weather!
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(weather.currentTemp)
                .font(.system(size: 100))
                .foregroundColor(.white)
                .offset(x: 30, y: 80)
            
            Spacer()
            
            DetailledWeather(city: city, weather: weather)
        }.background(Image("CityBackground", bundle: Bundle.module).resizable().aspectRatio(contentMode: .fill))
    }
    
    struct DetailledWeather: View {
        let city: CityWeather
        let weather: WeatherData
        
        var body: some View {
            VStack {
                Text("Cette semaine")
                    .subtitle()
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<weather.dailyWeather.count, id: \.self) { i in
                            DailyWeatherView(dailyWeather: weather.dailyWeather[i])
                        }
                    }
                }
                
                Spacer()
            }.frame(height: 150).frame(maxWidth: .infinity)
                .background(Color(UIColor.systemBackground))
                .background(Color(UIColor.systemBackground).frame(height: 50).cornerRadius(25).offset(y: -75))
        }
        
        struct DailyWeatherView: View {
            let dailyWeather: DailyWeather
            
            var body: some View {
                VStack {
                    Image(systemName: dailyWeather.weatherType.systemImage())
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.accentColor)
                        .padding(20)
                    
                    Text("\(dailyWeather.minTemp) - \(dailyWeather.maxTemp)")
                        .text()
                }
            }
        }
    }
}
