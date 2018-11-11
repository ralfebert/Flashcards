class FlashcardsModel {

    static let shared = FlashcardsModel()

    private init() {
    }

    var cards = [
        Card(frontText: "bird", backText: "Vogel"),
        Card(frontText: "tree", backText: "Haus")
    ]
}
