//
//  ViewController.swift
//  DovizCevirici
//
//  Created by Mesut As on 7.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usd: UILabel!
    @IBOutlet weak var eur: UILabel!
    @IBOutlet weak var btc: UILabel!
    @IBOutlet weak var jpy: UILabel!
    @IBOutlet weak var cad: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClick(_ sender: Any) {
        
        //1.Request & Session
        //2.Response & Data
        //3.Parsing & JSON Serialization
        
        //1.
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=351a1705d697acf0021ed35262fb5b9a")
        let session = URLSession.shared
        // Closure
        let task = session.dataTask(with: url!) { data, response, error in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                
                self.present(alert, animated: true, completion: nil)
            }else {
                //2.
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // ASYNC
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let eur = rates["EUR"] as? Double {
                                    self.usd.text = "EUR: \(eur)"
                                }
                                
                                if let usd = rates["USD"] as? Double {
                                    self.eur.text = "USD: \(usd)"
                                }
                                
                                if let btc = rates["BTC"] as? Double {
                                    self.btc.text = "BTC: \(btc)"
                                }
                                
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpy.text = "JPY: \(jpy)"
                                }
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cad.text = "CAD: \(cad)"
                                }
                                
                            }
                        }
                        
                        
                        
                    }catch{
                        print("Error")
                        
                    }
                    
                 
                    
                }
                    
                
            }
        }
        task.resume()
       
        
    }
    
   
    
}

