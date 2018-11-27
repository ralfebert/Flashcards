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

    var allSets : RESTResource<SetList> { get }
    func downloadSet(id: Int) -> RESTResource<TermList>

}


class URLFlashcardsAPIClient : FlashcardsAPIClient {

    var allSets: RESTResource<SetList> {
        let url = URL(string: "https://www.ralfebert.de/flashcards/sets.json")!
        return RESTResource(url: url)
    }

    func downloadSet(id : Int) -> RESTResource<TermList> {
        let url = URL(string: "https://www.ralfebert.de/flashcards/\(id).json")!
        return RESTResource(url: url)
    }

}

