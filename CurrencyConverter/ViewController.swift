//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Abdullah Saleem on 29/04/2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var FromButton: UIButton!
    @IBOutlet var FromNumber: UITextField!
    @IBOutlet var FromLabel: UILabel!
    
    @IBOutlet var ToButton: UIButton!
    @IBOutlet var ToNumber: UITextField!
    @IBOutlet var ToLabel: UILabel!
    
    @IBOutlet var ConvertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reciveFromLabel), name: Notification.Name("from"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reciveToLabel), name: Notification.Name("to"), object: nil)
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
        print(FromNumber.text!)
        Task {
            let res = await Convert(from: FromLabel.text!, to: ToLabel.text!, num: FromNumber.text!)
            ToNumber.text = String(res)
        }
        
    }
    
    
}

