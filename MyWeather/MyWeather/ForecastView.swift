//
//  ForecastView.swift
//  MyWeather
//
//  Created by Daniel Tobias on 2026. 03. 08..
//
import SwiftUI

struct ForecastView: View {
    
    let forecast: ForecastData
    
    private var dailyForecasts: [ListItem] {
        forecast.list.filter{ $0.dt_txt.contains("12:00:00")}
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("5 napos előrejelzés (Délben)")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(dailyForecasts) { item in
                        VStack(spacing: 12){
                            Text(formatDate(item.dt_txt))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
        
                            let iconName = item.weather.first?.icon ?? "01d"
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconName)@2x.png")) { image in
                                image
                                    .resizable()
                                    .renderingMode(.template)
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .foregroundColor(.blue)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                            
                            Text("\(Int(item.main.temp))°C")
                                .font(.headline)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 25)
                        .background(Color.secondary.opacity(0.1))
                        .cornerRadius(15)
                    }
                }
            }.padding(.horizontal)
        }
    }
    
    private func formatDate(_ dateString: String) -> String {
        let components = dateString.split(separator: " ")
        if let datePart = components.first {
            let dateComponents = datePart.split(separator: "-")
            if dateComponents.count == 3 {
                return "\(dateComponents[1]). \(dateComponents[2])."
            }
        }
        return dateString
    }
}

#Preview {
    MainWeatherView()
}
