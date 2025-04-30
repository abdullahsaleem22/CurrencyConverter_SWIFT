//
//  ApiCalls.swift
//  CurrencyConverter
//
//  Created by Abdullah Saleem on 30/04/2025.
//

import Foundation

func Convert (from:String, to:String, num:String) async  -> Double {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "openexchangerates.org"
    urlComponents.path = "/api/latest.json"
    urlComponents.queryItems = [
        URLQueryItem(name: "app_id", value: "d7b58765037e47e984a1ab1e7229be06")
    ]
    
    let url = urlComponents.url
    
    
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.timeoutInterval = 10
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(ExchangeRatesResponse.self, from: data)
        let fromRate = response.rates[from]
        let toRate = response.rates[to]
        
        var result = fromRate! * Double(num)!
        result = result * toRate!
        
        return result
        
    } catch {
        print("Error fetching currencies: \(error.localizedDescription)")
        return 0
        
    }
}

func getCurrencyList () async -> [Currency]{
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "openexchangerates.org"
    urlComponents.path = "/api/currencies.json"
    urlComponents.queryItems = [
        URLQueryItem(name: "app_id", value: "d7b58765037e47e984a1ab1e7229be06")
    ]
    
    let url = urlComponents.url
    
    
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.timeoutInterval = 10
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    
    do {
        let (data, _) = try await URLSession.shared.data(for: request)
        let currencyDictionary: [String: String] = try JSONDecoder().decode([String: String].self, from: data)
        var currencies : [Currency] = currencyDictionary.map { (key, value) in
            Currency(name: value, isoCode: key)
        }
        
        currencies.sort { $0.name < $1.name }
        
        return currencies        
    } catch {
        print("Error fetching currencies: \(error.localizedDescription)")
        return []
    }
}
