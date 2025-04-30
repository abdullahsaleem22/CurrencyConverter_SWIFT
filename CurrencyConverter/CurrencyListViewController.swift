//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Abdullah Saleem on 29/04/2025.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    
    @IBOutlet var table: UITableView!
    
    var label:String?
   
    var currencies: [Currency] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            currencies = await getCurrencyList()
            self.table.reloadData()
        }
        table.dataSource = self
        table.delegate = self
                
    }

}

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell")else{
            return UITableViewCell()
        }
        
        cell.textLabel?.text = currencies[indexPath.row].name + " - " + currencies[indexPath.row].isoCode
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name : String = label else{
            dismiss(animated: true)
            return
        }
        NotificationCenter.default.post(name: NSNotification.Name(name), object: currencies[indexPath.row].isoCode)
        dismiss(animated: true)
    }
}
