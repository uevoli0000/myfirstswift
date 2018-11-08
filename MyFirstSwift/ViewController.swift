//
//  ViewController.swift
//  MyFirstSwift
//
//  Created by 이연석 on 2018. 11. 2..
//  Copyright © 2018년 이연석. All rights reserved.
//

import UIKit

struct DataJSON : Decodable {
    let name:String
    let items : [DetailJSON]
}
struct DetailJSON : Decodable {
    let name:String
    let desc:String
}
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var datalist = [DataJSON]()
    var itemlist = [DetailJSON]()
    var tableRowCount = 0
    var customCell = [CustomCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let jsonFile = FileHandle(forReadingAtPath : "data.json")
        
//        let file = Bundle.main.path(forResource: "data", ofType: "json")
//
//        do {

//            let fileURL = URL(fileURLWithPath : "data.json")
//            let jsonFile = try FileHandle(forReadingFrom: fileURL)
//            let data:Data! = jsonFile.readDataToEndOfFile()
//            let data = try Data(contentsOf: URL(fileURLWithPath: file!), options: .mappedIfSafe)
//            datalist = try JSONDecoder().decode([DataJSON].self, from: data)

            //print(datalist)
//        }catch{
//            print(error)
//        }
        do {
            datalist = try Common.loadJSONfromLocalFile(type: [DataJSON].self, _filename: "data", _extension: "json")
        }catch{
            print(error)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return datalist.count
        } else {
            return datalist[pickerView.selectedRow(inComponent: 0)].items.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return datalist[row].name
        } else {
            return datalist[pickerView.selectedRow(inComponent: 0)].items[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(datalist[pickerView.selectedRow(inComponent: 0)].items[row].name)
        pickerView.reloadAllComponents()
    }
    
    @IBAction func tableAddClick(_ sender: Any) {
        tableRowCount += 1
        customCell.append(CustomCell())
        print("tableRowCount : \(tableRowCount)")
        tableView.reloadData()
    }
    
    @IBAction func itemAddClick(_ sender: Any) {
        print("테이블 행 갯수 : \(tableView.numberOfRows(inSection: 0))")
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! CustomCell
            print("\(i) : name=\(cell.nameTextField.text ?? "")")
        }
    }
    @IBAction func fileSaveClick(_ sender: Any) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection : \(tableRowCount)")
        return tableRowCount
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            as! CustomCell
        return cell
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        print("editActionsForRowAt : index\(indexPath.row)")
//    }
}
