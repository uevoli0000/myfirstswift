
import Foundation

class Common {
    static func loadJSONfromLocalFile <T : Decodable> (type: T.Type, _filename:String, _extension:String) throws -> T {
        return try JSONDecoder().decode(type, from: loadFromLocalFile(_filename: _filename, _extension: _extension)!)
    }
    static func loadFromLocalFile(_filename:String, _extension:String) -> Data?{
        let file = Bundle.main.path(forResource: _filename, ofType: _extension)
        do {
            
            //            let fileURL = URL(fileURLWithPath : "data.json")
            //            let jsonFile = try FileHandle(forReadingFrom: fileURL)
            //            let data:Data! = jsonFile.readDataToEndOfFile()
            let data = try Data(contentsOf: URL(fileURLWithPath: file!), options: .mappedIfSafe)
            
            return data
            //print(datalist)
        }catch{
            print(error)
        }
        return nil
    }
}
