import CoreData

class FlashcardsModel {

    static let shared = FlashcardsModel()

    let persistentContainer : NSPersistentContainer

    private init() {
        self.persistentContainer = NSPersistentContainer(defaultContainerWithName: "Flashcards")
    }

    private var viewContext : NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    var cards : [Card] {
        let fetchRequest : NSFetchRequest<Card> = Card.fetchRequest()
        return try! self.viewContext.fetch(fetchRequest)
    }

    func createCard() -> Card {
        return NSEntityDescription.insertNewObject(forEntityName: Card.entityName, into: self.viewContext) as! Card
    }

    func save() {
        try! self.viewContext.save()
    }

}
