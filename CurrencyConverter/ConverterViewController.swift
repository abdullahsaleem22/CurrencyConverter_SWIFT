//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Abdullah Saleem on 29/04/2025.
//

import UIKit

class ConverterViewController: UIViewController {

    @IBOutlet var FromButton: UIButton!
    @IBOutlet var FromNumber: UITextField!
    @IBOutlet var FromLabel: UILabel!
    
    @IBOutlet var ToButton: UIButton!
    @IBOutlet var ToNumber: UITextField!
    @IBOutlet var ToLabel: UILabel!
    
    @IBOutlet var ConvertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ToNumber.isUserInteractionEnabled = false
        ToNumber.layer.borderWidth = 1
        ToNumber.layer.borderColor = UIColor.systemOrange.cgColor
        ToNumber.layer.cornerRadius = 8
        ToNumber.layer.masksToBounds = true
        
        FromNumber.keyboardType = .decimalPad
        FromNumber.layer.borderWidth = 1
        FromNumber.layer.borderColor = UIColor.systemOrange.cgColor
        FromNumber.layer.cornerRadius = 8
        FromNumber.layer.masksToBounds = true
        FromNumber.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reciveFromLabel), name: Notification.Name("from"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reciveToLabel), name: Notification.Name("to"), object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! CurrencyListViewController
        
        destVC.label = sender as? String
    }
    
    @objc func reciveFromLabel(_ notification : Notification){
        self.FromLabel.text = notification.object as! String?;
    }
    @objc func reciveToLabel(_ notification : Notification){
        self.ToLabel.text = notification.object as! String?;
    }

    @IBAction func FromBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toList", sender: "from")
    }
    
    @IBAction func ToBtnClicked(_ sender: Any) {
        performSegue(withIdentifier: "toList", sender: "to")
    }
    
    @IBAction func ConvertBtnClicked(_ sender: Any) {
        guard let from:String = FromLabel.text else{
            return
        }
        
        guard let to:String = ToLabel.text else{
            return
        }
        
        guard let num:String = FromNumber.text else{
            return
        }
        
        Task {
            let res = await Convert(from: from, to: to, num: num)
            ToNumber.text = String(res)
        }
        
    }
    
    
}

extension ConverterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemOrange.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 1
    }
}


