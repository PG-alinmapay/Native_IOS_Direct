//
//  ReceptViewController.swift
//
//

import UIKit
import direct_ios_plugin


protocol IReceptViewController: class {
	var router: IReceptRouter? { get set }
}

class ReceptViewController: UIViewController {
	var interactor: IReceptInteractor?
	var router: IReceptRouter?

    var model: PaymentResultData? = nil
    var jsonData: [String: String] = [:]
    // var model: Model? // Assuming you have a Model class to hold your data

    var dict: [String: String] = [:]
    
    @IBOutlet var receptTableview: UITableView!
    @IBAction func btnPress(_ sender: Any)
    {
        backAction()
    }
    
//    var titles: [String] = ["Amount" , "Response" , "Transaction ID"  , "RESULT" , "Token Code","Card Brand","Masked PAN","Response Message","MetaData"]
//
//    var values: [String] = []
////
//    func convertToDictionary(jsonString: String) -> [String: Any]? {
//        guard let data = jsonString.data(using: .utf8) else { return nil }
//        do {
//            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
//            return jsonObject as? [String: Any]
//        } catch {
//            print("Error converting JSON string to dictionary: \(error)")
//            return nil
//        }
//    }
//
//    func convertToJsonString(from dictionary: [String: Any]) -> String? {
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
//            return String(data: jsonData, encoding: .utf8)
//        } catch {
//            print("Error converting dictionary to JSON string: \(error)")
//            return nil
//        }
//    }
//
    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = "RECEIPT"
            
            if let jsonString = model?.apiresponsedata {
                if let dictionary = convertToDictionary(jsonString: jsonString) {
                    jsonData = flatten(dictionary: dictionary)
                }
            }
            
            receptTableview.register(UINib(nibName: "ReceptCell", bundle: nil), forCellReuseIdentifier: "ReceptCell")
            receptTableview.dataSource = self
            receptTableview.delegate = self
            receptTableview.reloadData()
        }
        
        // Convert JSON string to Dictionary
        func convertToDictionary(jsonString: String) -> [String: Any]? {
            if let data = jsonString.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
            }
            return nil
        }
        
        // Flatten nested dictionary
        func flatten(dictionary: [String: Any], prefix: String = "") -> [String: String] {
            var result = [String: String]()
            
            for (key, value) in dictionary {
                result[key] = "\(value)"
                print(" IN FLATTEN DATA \(key) - \(value)")
//                let newKey = prefix.isEmpty ? key : "\(prefix).\(key)"
//                if let subDictionary = value as? [String: Any] {
//                    let flattenedSubDictionary = flatten(dictionary: subDictionary, prefix: newKey)
//                    for (subKey, subValue) in flattenedSubDictionary {
//                        result[subKey] = subValue
//                    }
//                } else {
//                    result[newKey] = "\(value)"
//                }
            }
            
            return result
        }
    }

    extension ReceptViewController: UITableViewDataSource, UITableViewDelegate {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
     
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return jsonData.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var  jsonvalue = ""
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceptCell") as! ReceptCell
            
            let keys = Array(jsonData.keys)
            let key = keys[indexPath.row]
            //print("\(key)")
           // print("\(keys)")
            if let value =  jsonData[key] as? [String: Any] {
                         jsonvalue = value.description
                      } else {
                          jsonvalue =  "(value as? [String: Any]"
                      }
            let value = jsonData[key] ?? "N/A"
           // self.titleLabel.text = value
            cell.setTitle(title: "\(key) :\(value) " , valuee: " \(jsonvalue)")
            // cell.detailTextLabel?.text = value
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 50
        }
       func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.dismiss(animated: true, completion: nil)
//    }  ////this is used to close the page on click 
}

extension ReceptViewController :IReceptViewController {
    func showData(jsonData: [String: String]) {
        self.jsonData = jsonData
        receptTableview.reloadData()
    }
}
