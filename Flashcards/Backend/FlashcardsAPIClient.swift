import Foundation

struct SetList : Codable {
    var sets : [SetDownload]
}

struct SetDownload : Codable {
    var id : Int
    var title : String
    var term_count : Int
}

protocol FlashcardsAPIClient {

    var allSets : SetList { get }
    func downloadSet(id: Int)

}


class DemoFlashcardsAPIClient : FlashcardsAPIClient {

    var allSets: SetList {
        let url = URL(string: "https://www.ralfebert.de/flashcards/sets.json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONDecoder().decode(SetList.self, from: data)
        return json
    }

    func downloadSet(id: Int) {
        fatalError("Noch nicht implementiert")
    }

}

