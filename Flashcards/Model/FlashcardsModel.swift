import CoreData

class FlashcardsModel {

    static let shared = FlashcardsModel()

    let persistentContainer : NSPersistentContainer

    private init() {
        self.persistentContainer = NSPersistentContainer(defaultContainerWithName: "Flashcards")
    }

    init(persistentContainer : NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    private var viewContext : NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }

    var cards : [Card] {
        let fetchRequest : NSFetchRequest<Card> = Card.fetchRequest()
        return try! self.viewContext.fetch(fetchRequest)
    }

    @discardableResult
    func createCard() -> Card {
        return NSEntityDescription.insertNewObject(forEntityName: Card.entityName, into: self.viewContext) as! Card
    }

    @discardableResult
    func createCard(frontText : String, backText : String) -> Card {
        let card = self.createCard()
        card.frontText = frontText
        card.backText = backText
        return card
    }

    func clear() {
        self.cards.forEach(self.viewContext.delete)
        save()
    }
    
    func save() {
        try! self.viewContext.save()
    }

}
