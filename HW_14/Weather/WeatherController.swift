//
//  WeatherController.swift
//  HW_14
//
//  Created by Юрий Четырин on 23.11.2019.
//  Copyright © 2019 Юрий Четырин. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    var localForecastWeather: [ForecastWeatherForSave] = []
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunrizeLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.addTarget(self, action: #selector(refreshWeather(_:)), for: .valueChanged)
        weatherTableView.refreshControl = refreshControl
        
        let curWeather: WeatherForSave = ToDoTaskRealm.shared.getCurWeather()
        if(curWeather.weatherDescription != ""){
            self.cityLabel.text = curWeather.city
            self.weatherLabel.text = curWeather.weatherDescription
            self.sunrizeLabel.text = curWeather.sunrise
            self.sunsetLabel.text = curWeather.sunset
            
            
            self.weatherImage.image = UIImage(named: curWeather.weatherIconID)!
            self.temperatureLabel.text = "\(Int(round(curWeather.temp)))°C"
            self.cloudCoverLabel.text = "\(curWeather.cloudCover)%"
            self.windLabel.text = "\(curWeather.windSpeed) м/с"
            self.pressureLabel.text = "\(curWeather.pressure) мм рт.ст."
            
            self.humidityLabel.text = "\(curWeather.humidity)%"
        }
        //ToDoTaskRealm.shared.clearForecastWeather()
        let forWeather = ToDoTaskRealm.shared.getForecastWeather()
        for val in forWeather {
            localForecastWeather.append(val)
        }
        self.weatherTableView.reloadData()
    }
    
    @objc private func refreshWeather(_ sender: Any) {
        fetchWeatherData()
    }
    
    private func fetchWeatherData() {
            WeatherLoader().loadCurWheatherAlamofire(city: "Moscow,ru", completion: {weather in
                self.cityLabel.text = weather.city
                self.weatherLabel.text = weather.weatherDescription
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.sunrizeLabel.text = formatter.string(from: weather.sunrise as Date)
                self.sunsetLabel.text = formatter.string(from: weather.sunset as Date)
                
                self.weatherImage.image = UIImage(named: weather.weatherIconID)!
                self.temperatureLabel.text = "\(Int(round(weather.temp)))°C"
                self.cloudCoverLabel.text = "\(weather.cloudCover)%"
                self.windLabel.text = "\(weather.windSpeed) м/с"
                self.pressureLabel.text = "\(weather.pressure) мм рт.ст."
                
                self.humidityLabel.text = "\(weather.humidity)%"
                ToDoTaskRealm.shared.setCurWeather(city: weather.city, weatherDescription: weather.weatherDescription, sunrise: formatter.string(from: weather.sunrise as Date), sunset: formatter.string(from: weather.sunset as Date), weatherIconID: weather.weatherIconID, temp: weather.temp, cloudCover: weather.cloudCover, windSpeed: weather.windSpeed, pressure: weather.pressure, humidity: weather.humidity);
//                WeatherToRealm.shared.addWeather(weather: weather)
            })
            
            WeatherLoader().loadForecastWeatherAlamofire(city: "Moscow,ru", completion: {forecastWeather in
                ToDoTaskRealm.shared.clearForecastWeather()
                self.localForecastWeather.removeAll()
                for val in forecastWeather{
                    let forecast = ForecastWeatherForSave()
                    forecast.dt_txt = val.dt_txt
                    forecast.weatherIconID = val.weatherIconID
                    forecast.temp = val.temp
                    forecast.humidity = val.humidity
                    forecast.pressure = val.pressure
                    forecast.cloudCover = val.cloudCover
                    self.localForecastWeather.append(forecast)
                }
                
//                self.localForecastWeather = forecastWeather
                for val in forecastWeather{
                    ToDoTaskRealm.shared.addForecastWeather(dt_txt: val.dt_txt, weatherIconID: val.weatherIconID, temp: val.temp, humidity: val.humidity, pressure: val.pressure, cloudCover: val.cloudCover)
                }
                self.weatherTableView.reloadData()
            })
            self.refreshControl .endRefreshing()
        }

}

extension WeatherController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localForecastWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell") as! WeatherCell
        let model = localForecastWeather[indexPath.row]
        cell.dateTimeLabel.text = model.dt_txt
        cell.temperatureLabel.text = "\(Int(round(model.temp)))°C"
        cell.iconWeatherImage.image = UIImage(named: model.weatherIconID)!
        cell.cloudyLabel.text = "\(model.cloudCover) %"
        cell.pressureLabel.text = "\(model.pressure)"
        cell.humidityLabel.text = "\(model.humidity) %"
        return cell
    }
}
