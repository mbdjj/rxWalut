//
//  CurrencyListViewModel.swift
//  rxWalut
//
//  Created by Marcin Bartminski on 04/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

struct CurrencyListViewModel {
    var currencies = PublishSubject<[Currency]>()
    var networkManager = NetworkManager.shared
    
    func fetchCurrencies() async {
        do {
            let items = try await networkManager.getCurrencyData(for: Currency(baseCode: "PLN"))
            
            currencies.onNext(items)
            currencies.onCompleted()
        } catch {
            print(error.localizedDescription)
        }
    }
}
