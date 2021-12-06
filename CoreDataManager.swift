
import CoreData

class FEFUCoreDataContainer {

    static let instance = FEFUCoreDataContainer()
    
    private init() { }
    
    private static let persistentContainerName = "HomeTask_3"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Self.persistentContainerName)
container.loadPersistentStores(completionHandler: { (storeDescription, error) in
    if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
    }
})
return container
}()

    
var context: NSManagedObjectContext {
return persistentContainer.viewContext
}


func saveContext() {
let context = persistentContainer.viewContext
guard context.hasChanges else {
    return
}
do {
    try context.save()
} catch {
    let nsError = error as NSError
    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
}
}
}
