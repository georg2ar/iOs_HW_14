//
//  WeatherRealm.swift
//  HW_14
//
//  Created by Юрий Четырин on 23.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import Foundation
import RealmSwift

/*class WeatherForSave: Object {
    
    @objc dynamic var city: String = ""
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var sunrise: String = ""
    @objc dynamic var sunset: String = ""
    @objc dynamic var weatherIconID: String = ""
    
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var cloudCover: Int = 0
    @objc dynamic var windSpeed: Double = 0.0
    @objc dynamic var pressure: Double = 0.0
    @objc dynamic var humidity: Int = 0
    
}

class WeatherRealm{
    static let shared = ToDoTaskRealm()
    private let realm = try!Realm()
    
    func setCurWeather(city: String, weatherDescription: String, sunrise: String, sunset: String, weatherIconID: String, temp: Double, cloudCover: Int, windSpeed: Double, pressure: Double, humidity: Int){
        let allWeather = realm.objects(WeatherForSave.self).first!
        try! realm.write {
            realm.delete(allWeather)
            
            let weather = WeatherForSave()
            weather.city = city
            weather.weatherDescription = weatherDescription
            weather.sunrise = sunrise
            weather.sunset = sunset
            weather.weatherIconID = weatherIconID
            weather.temp = temp
            weather.cloudCover = cloudCover
            weather.windSpeed = windSpeed
            weather.pressure = pressure
            weather.humidity = humidity
            realm.add(weather)
        }
    }
    
    func getCurWeather() -> WeatherForSave{
        let allWeather = realm.objects(WeatherForSave.self).first!
        return allWeather
    }
}*/
