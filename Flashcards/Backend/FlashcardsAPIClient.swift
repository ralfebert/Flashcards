import Foundation

struct SetList : Codable {
    var sets : [SetDownload]
}

struct SetDownload : Codable {
    var id : Int
    var title : String
    var term_count : Int
}


struct TermList : Codable {
    var id : Int
    var title : String
    var terms : [Term]
}

struct Term : Codable {
    var term : String
    var definition : String
}


protocol FlashcardsAPIClient {

    var allSets : SetList { get }
    func downloadSet(id: Int) -> TermList

}


class DemoFlashcardsAPIClient : FlashcardsAPIClient {

    var allSets: SetList {
        let url = URL(string: "https://www.ralfebert.de/flashcards/sets.json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONDecoder().decode(SetList.self, from: data)
        return json
    }

    func downloadSet(id : Int) -> TermList {
        let url = URL(string: "https://www.ralfebert.de/flashcards/\(id).json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONDecoder().decode(TermList.self, from: data)
        return json
    }

}

