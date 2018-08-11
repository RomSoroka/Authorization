//
//  CharacterTableViewController.swift
//  Authorization
//
//  Created by Рома Сорока on 11.08.2018.
//  Copyright © 2018 Рома Сорока. All rights reserved.
//

import UIKit

class CharacterTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let model = CharacterTableModel()
    
    fileprivate func handleReloadedTableView(_ error: (RespoceError?)) {
        DispatchQueue.main.async {
            guard error == nil else {
                Alert.showGetTextError(on: self)
                return
            }
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.loadChars { (error) in
            self.handleReloadedTableView(error)
        }
    }
    
    
}

extension CharacterTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.sortedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        let char = model.sortedArray[indexPath.row]
        cell.textLabel?.text = "<\" \(char == " " ? "space" : String(char) ) \"  -"
        cell.detailTextLabel?.text = "\(model.characterCount[char]!) times>"
        
        return cell
    }
    
    
}

extension CharacterTableViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.localeCodes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.localeCodes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.spinner.startAnimating()
        model.characterCount.removeAll()
        model.sortedArray.removeAll()
        tableView.reloadData()
        model.loadChars(locale: model.localeCodes[row]) { error in
            self.handleReloadedTableView(error)
        }
    }
    
}
