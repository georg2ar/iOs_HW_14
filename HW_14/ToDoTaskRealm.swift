//
//  ToDoTaskRealm.swift
//  HW_14
//
//  Created by Юрий Четырин on 20.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object{
    @objc dynamic var textTask = ""
    @objc dynamic var dateTimeTask = ""
}

class WeatherForSave: Object {
    
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

class ForecastWeatherForSave: Object{
    @objc dynamic var dt_txt: String = ""
    @objc dynamic var weatherIconID: String = ""
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var pressure: Double = 0.0
    @objc dynamic var cloudCover: Int = 0
}

class ToDoTaskRealm{
    static let shared = ToDoTaskRealm()
    
    private let realm = try!Realm()
    
    func addTask(date: String, textTask: String){
        try! realm.write {
            let task = Task()
            task.dateTimeTask = date
            task.textTask = textTask
            realm.add(task)
        }
    }
    
    func removeTask(date: String, textTask: String){
        try! realm.write {
            for val in realm.objects(Task.self){
                if(val.dateTimeTask == date && val.textTask == textTask){
                    realm.delete(val)
                }
            }
        }
    }
    
    func removeTask(task: Task){
        try! realm.write {
            realm.delete(task)
        }
    }
    
    func getTasks()->[Task]{
        var taskCollections: [Task] = []
        for val in realm.objects(Task.self){
            taskCollections.append(val)
        }
        return taskCollections
    }
    
    func setCurWeather(city: String, weatherDescription: String, sunrise: String, sunset: String, weatherIconID: String, temp: Double, cloudCover: Int, windSpeed: Double, pressure: Double, humidity: Int){
        let oldWeather = realm.objects(WeatherForSave.self)
//        let allWeather = realm.objects(WeatherForSave.self).first!
        try! realm.write {
            realm.delete(oldWeather)
            
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
        let weather = WeatherForSave()
        for val in realm.objects(WeatherForSave.self){
            weather.city = val.city
            weather.weatherDescription = val.weatherDescription
            weather.sunrise = val.sunrise
            weather.sunset = val.sunset
            weather.weatherIconID = val.weatherIconID
            weather.temp = val.temp
            weather.cloudCover = val.cloudCover
            weather.windSpeed = val.windSpeed
            weather.pressure = val.pressure
            weather.humidity = val.humidity
        }
        return weather
    }
    
    func clearForecastWeather(){
        let oldWeather = realm.objects(ForecastWeatherForSave.self)
        try! realm.write{
            for val in oldWeather{
                realm.delete(val)
            }
        }
    }
    
    func addForecastWeather(dt_txt: String, weatherIconID: String, temp: Double, humidity: Int, pressure: Double, cloudCover: Int){
        try! realm.write {
            
            let weather = ForecastWeatherForSave()
            weather.dt_txt = dt_txt
            weather.weatherIconID = weatherIconID
            weather.temp = temp
            weather.humidity = humidity
            weather.pressure = pressure
            weather.cloudCover = cloudCover
            realm.add(weather)
        }
    }
    
    func getForecastWeather()-> [ForecastWeatherForSave]{
        var forecastWeather: [ForecastWeatherForSave] = []
        for val in realm.objects(ForecastWeatherForSave.self){
            forecastWeather.append(val)
        }
        return forecastWeather
    }
}
