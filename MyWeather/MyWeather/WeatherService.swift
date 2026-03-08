//
//  WeatherService.swift
//  MyWeather
//
//  Created by Daniel Tobias on 2026. 03. 08..
//
import SwiftUI

@Observable class WeatherService {
    
    private let apiKey = "ded57e674a40589aab186c96e76b31ac"
    
    var currentWeather: CurrentWeatherData?
    var forecast: ForecastData?
    var isLoading: Bool = false
    var errorMessage: String?
    
    
    func fetchWeather(for city: String)async {
        isLoading = true
        errorMessage = nil
        
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=\(apiKey)&units=metric")
        else {
            self.errorMessage = "Hibás URL formátum."
            self.isLoading = false
            return
        }
            
        //guard let response = try? await URLSession.shared.data(for: URLRequest(url:url))
        //else {
        //    return
        //}
                    
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(CurrentWeatherData.self, from: data)
            self.currentWeather = decodedData
            
            //self.weatherInfo = try JSONDecoder().decode(WeatherInfo.self, from: response.0)
        }
        catch(let error) {
            self.errorMessage = "Hiba az adatok letöltésekor: \(error.localizedDescription)"
            print("Weather Fetch Error: \(error)")
        }
        
        isLoading = false
    }
    
    
    func fetchForecast(for city: String) async {
        isLoading = true
        errorMessage = nil
        
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(encodedCity)&appid=\(apiKey)&units=metric")
        else {
            self.errorMessage = "Hibás URL formátum."
            self.isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(ForecastData.self, from: data)
            self.forecast = decodedData
            
        } catch {
            self.errorMessage = "Hiba az előrejelzés letöltésekor: \(error.localizedDescription)"
            print("Forecast Fetch Error: \(error)")
        }
        
        isLoading = false
    }
    
}
