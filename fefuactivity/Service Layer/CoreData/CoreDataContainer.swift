
import CoreData

/// Пример реализации контейнера для работы с CoreData
///
/// Прячет внутреннюю работу с CoreData через этот класс
class FEFUCoreDataContainer {
    
    /// Обычный синглтон
    ///
    /// Да-да, антипаттерн, но пока об этом думать рано
    ///
    /// eg: FEFUCoreDataContainer.instance.context
    static let instance = FEFUCoreDataContainer()
    
    private init() { }
    
    /// Имя контейнера
    ///
    /// Зависит от того, как вы его создали. Обычно, он соответствует названию проекта
    /// На лекциях это так и будет
    private static let persistentContainerName = "fefuactivity"
    
    // MARK: - Privates
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Self.persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Public properties
    
    /// текущий контекст для CRUD
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Public functions
    
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
