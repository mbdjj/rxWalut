//
//  ViewController.swift
//  rxWalut
//
//  Created by Marcin Bartminski on 04/12/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var viewModel = CurrencyListViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableData()
    }
    
    
    func bindTableData() {
        viewModel.currencies.bind(to: tableView.rx.items(cellIdentifier: "currencyCell", cellType: CurrencyCell.self)) { row, item, cell in
            cell.flagLabel.text = item.flag
            cell.nameLabel.text = item.fullName
            cell.codeLabel.text = item.code
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Currency.self).bind { currency in
            print(currency.flag + " " + currency.fullName)
            
            if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
            }
        }.disposed(by: bag)
        
        Task {
            await viewModel.fetchCurrencies()
        }
    }

}

class CurrencyCell: UITableViewCell {
    @IBOutlet var flagLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var codeLabel: UILabel!
}

