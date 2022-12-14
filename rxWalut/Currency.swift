//
//  Currency.swift
//  rxWalut
//
//  Created by Marcin Bartminski on 04/12/2022.
//

import Foundation

struct Currency: Identifiable, Equatable {
    
    init(code: String, rate: Double, yesterday: Double) { //We can initiate a Currency object
        self.code = code
        self.rate = rate
        self.yesterdayRate = yesterday
    }
    
    init(baseCode: String) {
        self.code = baseCode
        self.rate = 1.0
        self.yesterdayRate = 1.0
    }
    
    let code: String
    var flag: String { getEmoji(of: code) }
    var fullName: String { getName(of: code) }
    var symbol: String { getSymbol(of: code) }
    let rate: Double
    let yesterdayRate: Double
    var price: Double { 1 / rate }
    var yesterdayPrice: Double { 1 / yesterdayRate }
    
    var isFavorite: Bool = false
    
    var id: String { code }
    
    //MARK: - Manager part
    //Those are the methods that help to get all the info of specific currencies.
    
    private let emojiDictionary = [
        "AUD": "๐ฆ๐บ",
        "BRL": "๐ง๐ท",
        "BGN": "๐ง๐ฌ",
        "CAD": "๐จ๐ฆ",
        "CNY": "๐จ๐ณ",
        "HRK": "๐ญ๐ท",
        "CZK": "๐จ๐ฟ",
        "DKK": "๐ฉ๐ฐ",
        "EUR": "๐ช๐บ",
        "HKD": "๐ญ๐ฐ",
        "HUF": "๐ญ๐บ",
        "INR": "๐ฎ๐ณ",
        "IDR": "๐ฎ๐ฉ",
        "ILS": "๐ฎ๐ฑ",
        "JPY": "๐ฏ๐ต",
        "MYR": "๐ฒ๐พ",
        "MXN": "๐ฒ๐ฝ",
        "RON": "๐ท๐ด",
        "NZD": "๐ณ๐ฟ",
        "NOK": "๐ณ๐ด",
        "PHP": "๐ต๐ญ",
        "PLN": "๐ต๐ฑ",
        "GBP": "๐ฌ๐ง",
        "RUB": "๐ท๐บ",
        "SGD": "๐ธ๐ฌ",
        "ZAR": "๐ฟ๐ฆ",
        "KRW": "๐ฐ๐ท",
        "SEK": "๐ธ๐ช",
        "CHF": "๐จ๐ญ",
        "THB": "๐น๐ญ",
        "TRY": "๐น๐ท",
        "USD": "๐บ๐ธ"
    ]
    
    private let symbolDictionary = [
        "AUD": "$",
        "BRL": "R$",
        "BGN": "ะปะฒ.",
        "CAD": "$",
        "CNY": "ยฅ",
        "HRK": "kn",
        "CZK": "Kฤ",
        "DKK": "kr",
        "EUR": "โฌ",
        "HKD": "$",
        "HUF": "Ft",
        "INR": "โน",
        "IDR": "Rp",
        "ILS": "โช",
        "JPY": "ยฅ",
        "MYR": "RM",
        "MXN": "$",
        "RON": "lei",
        "NZD": "$",
        "NOK": "kr",
        "PHP": "โฑ",
        "PLN": "zล",
        "GBP": "ยฃ",
        "RUB": "โฝ",
        "SGD": "$",
        "ZAR": "R",
        "KRW": "โฉ",
        "SEK": "kr",
        "CHF": "Fr.",
        "THB": "เธฟ",
        "TRY": "โบ",
        "USD": "$"
    ]
    
    private let nameDictionary = [
        "AUD": String(localized: "AUD"),
        "BRL": String(localized: "BRL"),
        "BGN": String(localized: "BGN"),
        "CAD": String(localized: "CAD"),
        "CNY": String(localized: "CNY"),
        "HRK": String(localized: "HRK"),
        "CZK": String(localized: "CZK"),
        "DKK": String(localized: "DKK"),
        "EUR": String(localized: "EUR"),
        "HKD": String(localized: "HKD"),
        "HUF": String(localized: "HUF"),
        "INR": String(localized: "INR"),
        "IDR": String(localized: "IDR"),
        "ILS": String(localized: "ILS"),
        "JPY": String(localized: "JPY"),
        "MYR": String(localized: "MYR"),
        "MXN": String(localized: "MXN"),
        "RON": String(localized: "RON"),
        "NZD": String(localized: "NZD"),
        "NOK": String(localized: "NOK"),
        "PHP": String(localized: "PHP"),
        "PLN": String(localized: "PLN"),
        "GBP": String(localized: "GBP"),
        "RUB": String(localized: "RUB"),
        "SGD": String(localized: "SGD"),
        "ZAR": String(localized: "ZAR"),
        "KRW": String(localized: "KRW"),
        "SEK": String(localized: "SEK"),
        "CHF": String(localized: "CHF"),
        "THB": String(localized: "THB"),
        "TRY": String(localized: "TRY"),
        "USD": String(localized: "USD")
    ]
    
    private func getEmoji(of currency: String) -> String {
        return emojiDictionary[currency]!
    }
    
    private func getSymbol(of currency: String) -> String {
        return symbolDictionary[currency]!
    }
    
    private func getName(of currency: String) -> String {
        return nameDictionary[currency]!
    }
}
