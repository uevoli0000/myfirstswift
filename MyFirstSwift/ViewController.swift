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
        //tableRowCount += 1
        customCell.append(CustomCell())
        print("tableRowCount : \(tableRowCount)")
        tableView.reloadData()
    }
    
    @IBAction func itemAddClick(_ sender: Any) {
        print("테이블 행 갯수 : \(tableView.numberOfRows(inSection: 0))")
        for i in 0..<tableView.numberOfRows(inSection: 0) {
            let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! CustomCell
            print("\(i) : name=\(cell.nameLabel.text ?? "")")
        }
    }
    @IBAction func fileSaveClick(_ sender: Any) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection : \(customCell.count)")
        return customCell.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    /**
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.customCell.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
        }
    }
 **/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt :: \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            as! CustomCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        /**
        if indexPath != nil {
            guard let cell:CustomCell = tableView.cellForRow(at: indexPath!) as? CustomCell else {
                print("nothing cell...1")
                return
            }
            print("didEndEditingRowAt :: \(indexPath!.row) : name=\(cell.nameTextField.text ?? "")")
        } else {
            print("nothing cell...2")
        }
 **/
        //tableView.reloadData()
    }
    /*
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, handler) in
            //print("before customCell Array: \(self.customCell.count)")
            //tableView.beginUpdates()
            
            print("delete row : \(indexPath.row)")
            self.customCell.remove(at :indexPath.row)
            //print("after customCell Array: \(self.customCell.count)")
            
            /**
            var tempStr = ""

            for i in 0..<tableView.numberOfRows(inSection: 0) {
                let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! CustomCell
                tempStr += " \(cell.nameTextField.text ?? " ")"
            }
 **/
            //print("\(tempStr)")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.none)
            //tableView.endUpdates()
            //tableView.reloadData()
            //
        }
        deleteAction.backgroundColor = .red
        let image = UIGraphicsImageRenderer(size: CGSize(width: 30, height: 30)).image { _ in
            UIImage(named:"51032.gif")?.draw(in: CGRect(x: 0, y: 0, width: 30, height: 30))
        }
        deleteAction.image = image
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }**/
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "❌\n Delete") { (action, indexPath) in
            // delete item at indexPath
            self.customCell.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //print(self.tableArray)
        }
        
        delete.backgroundColor = .red
        //delete.backgroundColor = UIColor(patternImage: UIImage(named:"51032.gif")!)
        
        let share = UITableViewRowAction(style: .default, title: "Share") { (action, indexPath) in
            // share item at indexPath
            print("I want to share: ")
        }
        
        share.backgroundColor = UIColor.lightGray
        
        return [delete, share]
    }
}
