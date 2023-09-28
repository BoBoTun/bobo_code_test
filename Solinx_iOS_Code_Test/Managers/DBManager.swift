import Foundation
import RealmSwift
//import RxSwift
//import RxRelay
//import RxRealm


//enum  ROname : String {
//    case FavouritePostRO
//    case RecentPostRO
//    case RecentChattedUserRO
//    case BusStopRO
//    case BusLineRO
//    case ExpenseCategoryRO
//    case ExpenseSubCategoryRO
//    case TransactionRO
//    case TransactionImageRO
//    case SelectedMenuRO
//    case DictionaryRO
//}
//
//enum  ROnameForExpense : String {
//    case TransactionRO
//    case ExpenseCategoryRO
//    case ExpenseSubCategoryRO
//    case ExpenseSubcategoryIconRO
//    case TransactionImageRO
//}

class DBManager {
    private var   database:Realm
    static let   sharedInstance = DBManager()
    private var currentID: Int = 0
    
    private init() {
        database = try! Realm()
        print("Realm >> ", Realm.Configuration.defaultConfiguration.fileURL!)
    }
}
/*
 /*
 class DBManager {
 private var database: Realm
 static let shared = DBManager()
 private override init() {
 database = try! Realm()
 }
 func getDataFromDB<T: Object>(type: T.Type) -> Results<T> {
 let results: Results<T> = database.objects(type)
 return results
 }
 func addData<T: Object>(object: T) {
 try! database.write {
 database.add(object, update: true)
 }
 }
 func addData<T: Object>(objects: [T]) {
 try! database.write {
 database.add(objects, update: true)
 }
 }
 func deleteAllFromDatabase() {
 try! database.write {
 database.deleteAll()
 }
 }
 func deleteFromDb<T: Object>(object: T) {
 try! database.write {
 database.delete(object)
 }
 }
 func getDataWith<T: Object>(type: T.Type, condition: String) ->Results<T> {
 return database.objects(type).filter(condition)
 }
 }
  */
 */

extension DBManager {
    func nextUserID() -> Int {
            //let realm = try! Realm()
            if let maxID = database.objects(UserRo.self).max(ofProperty: "id") as Int? {
                currentID = maxID + 1
            } else {
                currentID = 1
            }
            return currentID
    }
    //MARK: - General CRUD
    public func retrieveDataList<T: Object>(type: T.Type) -> Results<T> {
        let array = database.objects(type)//database.objects(T.self)
        return array//Observable.array(from: array)
    }
    func getDataWith<T: Object>(type: T.Type, condition: String) ->Results<T> {
        return database.objects(type).filter(condition)
    }
    
    //MARK:- retrieve by predicate
    func getObjectByName(name : String) -> Object? {
        let predicate = NSPredicate(format: "name == \(name)")
        let result = database.objects(UserRo.self).filter(predicate)
        return result.count > 0 ? result[0] : nil
    }

    /*
    public func retrieveData<T>(value: T.Type) -> Observable<T> where T: Object {
        guard let data = database.objects(T.self).first else {
            return Observable.empty()
        }
        return Observable.from(object: data)
    }
    
    public func retrieveDataByKey<T>(value: T.Type, key: String, id: Int) -> Observable<T> where T: Object {
        guard let data = database.objects(T.self).filter("\(key) = %@", id).first else{
            return Observable.empty()
        }
        return Observable.from(object: data)
    }
    */
    
    public func saveDataList<T>(dataList: [T], value: T.Type, failure: @escaping (String) -> Void) where T : Object {
        do{
            database.refresh()
            try database.write{
                dataList.forEach { (item) in
                    saveData(data: item, value: T.self) { (err) in
                        failure(err)
                    }
                }
            }
            
        }catch let exception {
            failure(exception.localizedDescription)
        }
    }
    
    public func saveData<T>(data: T, value: T.Type, failure: @escaping (String) -> Void) where T : Object {
        do{
            database.refresh()
            try database.write{
                database.add(data, update: .modified)
            }
            
        }catch let exception {
            print("Failed to save")
            failure(exception.localizedDescription)
        }
    }
    
//    public func saveDataWithBackgroundThread<T>(data: T, value: T.Type, failure: @escaping (String) -> Void) where T : Object {
//        DispatchQueue.global(qos: .background).async { [unowned self] in
//            do{
//                database = try! Realm()
//                try database.safeWrite{
//                    database.add(data, update: .modified)
//                }
//
//            }catch let exception {
//                print("Failed to save")
//                failure(exception.localizedDescription)
//            }
//        }
//    }
    
    public func updateData(_ closure: @escaping () -> Void, failure: @escaping (String) -> Void) {
        do {
            database.refresh()
            try database.write {
                closure()
            }
        } catch {
            failure(error.localizedDescription)
        }
    }
    
    public func deleteDataList<T>(value: T.Type, success: @escaping(() -> Void), failure: @escaping(String) -> Void) where T: Object {
        do{
            database.refresh()
            try database.write{
                database.delete(database.objects(T.self))
                success()
            }
        }catch let exception {
            failure(exception.localizedDescription)
        }
    }
    
    func deleteData(objectArray: [Object], success: @escaping(() -> Void), failure: @escaping(String) -> Void )   {
        do{
            try database.write {
                database.delete(objectArray)
                print("completely deleted . . . ")
            }
            success()
        } catch {
            print("Realm Debug : error occur when deleting \(error)")
            failure(error.localizedDescription)
        }
    }
    /*
    func deleteData(id : Int64,roName : ROname){
        do {
            try database.write {
                if let object = getObjectById(id: id, roName: roName) {
                    database.delete(object)
                    print("amm testing Successfully Deleted")
                }else{
                    print("amm object not found")
                }
            }
        }catch _ {
            print("amm testing Fail to delete")
            
        }
    }
    */
    
//    func updateDictionaryItem(id : Int64, isFavourite : Bool){
//        if let item = getObjectById(id: id, roName: .DictionaryRO) as? DictionaryRO {
//            try! database.write {
//                item.isFavourite = isFavourite
//            }
//        }
//    }
    
    
    func deleteRealmData(success: @escaping(() -> Void), failure: @escaping(String) -> Void) {
        do{
            try database.write{
                database.deleteAll()
            }
            success()
            
        }catch let exception {
            failure(exception.localizedDescription)
        }
    }
    /*
    //MARK: - retrieve data list
    func getDataFromDB(roName : ROname) ->   [Object]! {
        switch roName {
        case .RecentChattedUserRO:
            let results : Results<RecentChattedUserRO> = database.objects(RecentChattedUserRO.self)
            return Array(results)
        case .FavouritePostRO :
            return []
        case .RecentPostRO :
            return []
        case .BusStopRO:
            return []
        case .BusLineRO:
            let results : Results<BusLineRO> = database.objects(BusLineRO.self)
            return Array(results)
        case .ExpenseCategoryRO:
            return []
        case .ExpenseSubCategoryRO:
            return []
        case .TransactionRO:
            return []
        case .TransactionImageRO:
            return []
        case .SelectedMenuRO:
            return []
        case .DictionaryRO:
            return []
        }
    }
    
    //MARK:- retrieve by predicate
    func getObjectById(id : Int64,roName : ROname) -> Object? {
        let predicate = NSPredicate(format: "id == \(id)")
        let menuPredicate = NSPredicate(format: "foodMenuId ==\(id)")
        
        switch roName {
        case .FavouritePostRO:
            return nil
//
        case .RecentPostRO:
            let result = database.objects(RecentPostRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .RecentChattedUserRO :
            let result = database.objects(RecentChattedUserRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .BusStopRO :
            return nil
        case .BusLineRO:
            let result = database.objects(BusLineRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .ExpenseCategoryRO:
            return database.objects(ExpenseCategoryRO.self).filter(predicate).first
        case .ExpenseSubCategoryRO:
            return database.objects(ExpenseSubCategoryRO.self).filter(predicate).first
        case .TransactionRO:
            return database.objects(TransactionRO.self).filter(predicate).first
        case .TransactionImageRO:
            return database.objects(TransactionImageRO.self).filter(predicate).first
        case .SelectedMenuRO:
            return database.objects(SelectedMenuRO.self).filter(menuPredicate).first
        case .DictionaryRO:
            return database.objects(DictionaryRO.self).filter(predicate).first
    
        }
        
    }
    
    //MARK:- read and save csv file from resource
        func readDataFromCSV(tsvFileName: String,dictionaryFileNameObject : DictionaryFileNameRO){
            var resultData = [DictionaryRO]()
            var csvData: String? = nil
            var csvPath = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
            csvPath.appendPathComponent(tsvFileName, isDirectory: true)
            

            do {
                csvData = try String(contentsOf: csvPath, encoding: String.Encoding.utf8)
                let csv = csvData?.csvRows()
                resultData.removeAll()
                var i = 1
                for row in csv!{
                    
                    let temp = DictionaryRO(id: Int64(i), mmDescription: row[0], engDescription: row[1], type: row[2],isFavourite: false , isVisible: false)
                    resultData.append(temp)
                    i += 1
                }
                try FileManager.default.removeItem(at: csvPath)
                saveDataList(dataList: resultData, value: DictionaryRO.self) { (error) in
                    print("Error> Failed to save diectionary tsv file list > \(error)")
                }
                saveData(data: dictionaryFileNameObject, value: DictionaryFileNameRO.self) { (error) in
                    print("Error> Failed to save diectionary file name > \(error)")
                }
                
            } catch{
                print(error)
            }
        }
    
    //MARK:- read and save csv file from resource for expense
    func readDataFromCSVForExpense(tsvFileName: String, roName : ROnameForExpense){
        
        var resultData = [Object]()
        var csvData: String? = nil
//        do {
            csvData = try? String(contentsOfFile: tsvFileName, encoding: .utf8)
            let csv = csvData?.csvRows() ?? [[]]
            resultData.removeAll()
            
            if csv.count > 1 {
                for row in 1...(csv.count ) - 1{
                    var temp = Object()
                    switch roName {
                    case .TransactionRO :
                        temp = TransactionRO(id: Int64(csv[row][0]), amount: Double(csv[row][1]), subCategoryId: Int(csv[row][2]), categoryId: Int(csv[row][3]), note: csv[row][4], date: csv[row][5])
                        print(temp)
                    case .ExpenseCategoryRO:
                        temp = ExpenseCategoryRO(id: Int(csv[row][0]), categoryName: csv[row][1], appearance: csv[row][2], categoryType: Int(csv[row][3]))
                    case .ExpenseSubCategoryRO:
                        temp = ExpenseSubCategoryRO(id: Int(csv[row][0]), subCategoryName: csv[row][1], categoryId: Int(csv[row][2]), iconId: Int(csv[row][3]))
                    case .ExpenseSubcategoryIconRO:
                        temp = ExpenseSubcategoryIconRO(id: Int(csv[row][0]), iconPath: csv[row][1])
                    case .TransactionImageRO:
                        temp = TransactionImageRO(id: Int64(csv[row][0]), filePath: csv[row][1] , transactionId: Int(csv[row][2]) )
                    }
                    resultData.append(temp)
                }
            }
            switch  roName {
            case .TransactionRO:
                saveDataList(dataList: resultData as! [TransactionRO], value: TransactionRO.self) { (error) in
                    print("Error> Failed to save diectionary tsv file list > \(error)")
                }
            case .ExpenseCategoryRO:
                saveDataList(dataList: resultData as! [ExpenseCategoryRO], value: ExpenseCategoryRO.self) { (error) in
                    print("Error> Failed to save diectionary tsv file list > \(error)")
                }
            case .ExpenseSubCategoryRO:
                saveDataList(dataList: resultData as! [ExpenseSubCategoryRO], value: ExpenseSubCategoryRO.self) { (error) in
                    print("Error> Failed to save diectionary tsv file list > \(error)")
                }
            case .ExpenseSubcategoryIconRO:
                saveDataList(dataList: resultData as! [ExpenseSubcategoryIconRO], value: ExpenseSubcategoryIconRO.self) { (error) in
                    print("Error> Failed to save diectionary tsv file list > \(error)")
                }
            case .TransactionImageRO:
                saveDataList(dataList: resultData as! [TransactionImageRO], value: TransactionImageRO.self) { (error) in
                    print("Error> Failed to save diectionary tsv file list > \(error)")
                }
            }
//        } catch{
//            print(error)
//        }
    }
     */
}

