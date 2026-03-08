//
//  MainWeatherView.swift
//  MyWeather
//
//  Created by Daniel Tobias on 2026. 03. 08..
//
import SwiftUI

struct MainWeatherView: View {
    
    @State private var svc: WeatherService = WeatherService()
    
    @State private var currentCity: String = "Budapest"
    @State private var showingSearchSheet = false
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if svc.isLoading {
                    ProgressView("Időjárási adatok betöltése...")
                        .scaleEffect(1.2)
                        .padding()
                }
                else if let errorMessage = svc.errorMessage {
                    VStack(spacing: 10) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        Text("Hiba történt")
                            .font(.headline)
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                else if let weather = svc.currentWeather {
                    VStack(spacing: 15) {
                        Text(weather.name)
                            .font(.system(size: 40, weight: .bold))
                        
                        let iconName = weather.weather.first?.icon ?? "01d"
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")) { image in
                            image
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.blue)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 150, height: 150)
                        }
                        
                        Text("\(Int(weather.main.temp))°C")
                            .font(.system(size: 70, weight: .medium))
                        
                        if let description = weather.weather.first?.description {
                            Text(description.capitalized)
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack(spacing: 40) {
                            VStack {
                                Image(systemName: "humidity")
                                Text("\(weather.main.humidity)%")
                            }
                            VStack {
                                Image(systemName: "wind")
                                Text("\(weather.wind.speed, specifier: "%.1f") m/s")
                            }
                        }
                        .font(.headline)
                        .padding(.top, 20)
                        
                        if let forecast = svc.forecast {
                            NavigationLink("5 napos előrejelzés") {
                                ForecastView(forecast: forecast)
                                    .navigationTitle("Előrejelzés")
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.top, 20)
                        }
                        
                        Spacer()
                    }.padding(.top, 40)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showingSearchSheet = true
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .fontWeight(.bold)
                    }
                }
            }
            .sheet(isPresented: $showingSearchSheet){
                CitySearchView(currentCity: $currentCity, weatherService: svc)
            }
        }.task {
            await svc.fetchWeather(for: currentCity)
            await svc.fetchForecast(for: currentCity)
        }
        
    }
}

#Preview {
    MainWeatherView()
}
