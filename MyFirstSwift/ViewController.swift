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
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var datalist = [DataJSON]()
    var itemlist = [DetailJSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let jsonFile = FileHandle(forReadingAtPath : "data.json")
        
        let file = Bundle.main.path(forResource: "data", ofType: "json")
//        var readString = ""
//        do {
//            readString = try String(contentsOfFile: file!, encoding: String.Encoding.utf8)
//        } catch {
//            print("error : \(error)")
//        }
        //print(readString)
        do {

//            let fileURL = URL(fileURLWithPath : "data.json")
//            let jsonFile = try FileHandle(forReadingFrom: fileURL)
//            let data:Data! = jsonFile.readDataToEndOfFile()
            let data = try Data(contentsOf: URL(fileURLWithPath: file!), options: .mappedIfSafe)
            datalist = try JSONDecoder().decode([DataJSON].self, from: data)

            //print(datalist)
        }catch{
            print(error)
        }
        print("Hello")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return datalist.count
        } else {
            //return itemlist.count
            return datalist[pickerView.selectedRow(inComponent: 0)].items.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return datalist[row].name
        } else {
            //return itemlist[row].name
            
            return datalist[pickerView.selectedRow(inComponent: 0)].items[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(datalist[pickerView.selectedRow(inComponent: 0)].items[row].name)
        pickerView.reloadAllComponents()
    }
}
