//
//  NetworkManager.swift
//  rxWalut
//
//  Created by Marcin Bartminski on 04/12/2022.
//

import Foundation

struct NetworkManager {
    
    private let decoder = JSONDecoder()
    private let allCodesArray = ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK", "SGD", "THB", "TRY", "USD", "ZAR"]
    
    static let shared = NetworkManager()
    
    
    func getCurrencyData(for base: Currency) async throws -> [Currency] {
        guard let url = URL(string: "https://api.exchangerate.host/latest?base=\(base.code)") else {
            throw NetworkError.invalidURL
        }
        guard let yesterdayUrl = URL(string: "https://api.exchangerate.host/\(yesterdayString())?base=\(base.code)") else {
            throw NetworkError.invalidURL
        }
        
        let req = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        let (data, response) = try await URLSession.shared.data(for: req)
        
        let yesterdayReq = URLRequest(url: yesterdayUrl, cachePolicy: .reloadIgnoringLocalCacheData)
        let (yesterdayData, yesterdayResponse) = try await URLSession.shared.data(for: yesterdayReq)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        guard let yesterdayResponse = yesterdayResponse as? HTTPURLResponse, yesterdayResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let results = try decoder.decode(CurrencyData.self, from: data)
            let yesterdayResults = try decoder.decode(CurrencyData.self, from: yesterdayData)
            
            var currencyArray = [Currency]()
            
            for code in self.allCodesArray {
                let currency = Currency(code: code, rate: results.rates.getRate(of: code), yesterday: yesterdayResults.rates.getRate(of: code))
                currencyArray.append(currency)
            }
            
            print("Fetched currency data for \(base.code)")
            //self.saveDate()
            
            return currencyArray
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    func yesterdayString() -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd"
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now)
        let yesterdayString = formatter.string(from: yesterday!)
        
        return yesterdayString
    }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case decodingError
    }
    
}
