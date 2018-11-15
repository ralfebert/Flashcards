struct SetDownload {
    var id : Int
    var title : String
    var term_count : Int
}

protocol FlashcardsAPIClient {

    var allSets : [SetDownload] { get }
    func downloadSet(id: Int)

}


class DemoFlashcardsAPIClient : FlashcardsAPIClient {

    var allSets: [SetDownload] = [
        SetDownload(id: 1, title: "German/English: Common verbs", term_count: 50),
        SetDownload(id: 2, title: "Spanish/English: Animals", term_count: 100)
    ]

    func downloadSet(id: Int) {
        fatalError("Noch nicht implementiert")
    }

}

