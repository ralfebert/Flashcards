protocol FlashcardsAPIClient {

    var allSets : [String] { get }
    func downloadSet(id: Int)

}


class DemoFlashcardsAPIClient : FlashcardsAPIClient {

    var allSets: [String] = ["German/English: Common verbs", "Spanish/English: Animals"]

    func downloadSet(id: Int) {
        fatalError("Noch nicht implementiert")
    }

}

