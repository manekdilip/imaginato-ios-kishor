//
//  DataManager.swift
//  Imaginato

import UIKit
import CoreData


class DataManager: NSObject {

    static let shared = DataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Imaginato")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

//MARK:- Stored user detail on local database
//MARK:-

func createData(userData:User){
    
    //We need to create a context from this container
    let managedContext = DataManager.shared.persistentContainer.viewContext
    //Now let’s create an entity and new user records.
    let userEntity = NSEntityDescription.entity(forEntityName: "LoginUser", in: managedContext)!
    
    let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
    user.setValue(userData.userId, forKeyPath: "userId")
    user.setValue(userData.userName, forKey: "userName")
    user.setValue(userData.createdAt, forKey: "created_at")
    
    //Now we have set all the values. The next step is to save them inside the Core Data
    do {
        try managedContext.save()
        
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

//MARK:- Get user detail from local database
//MARK:-

func retrieveData() -> [User] {
    
    var arrUserDetail = [User]()
    let managedContext = DataManager.shared.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginUser")
    do {
        let result = try managedContext.fetch(fetchRequest)
        for itemData in result as! [NSManagedObject] {
            let keys = Array(itemData.entity.attributesByName.keys)
            let dict = itemData.dictionaryWithValues(forKeys: keys)
            let modelItem = User(object:dict)
            arrUserDetail.append(modelItem)
        }
        return arrUserDetail
    } catch {
        return arrUserDetail
    }
}

//MARK:- Delete user detail from local database
//MARK:-

func deleteData(aItem:User){
    
    let managedContext = DataManager.shared.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginUser")
    fetchRequest.predicate = NSPredicate(format: "id = %@", aItem.userId!)
    do{
        let test = try managedContext.fetch(fetchRequest)
        let objectToDelete = test[0] as! NSManagedObject
        managedContext.delete(objectToDelete)
        do{
            try managedContext.save()
        }catch
        {
            print(error)
        }
    } catch {
        print(error)
    }
}
