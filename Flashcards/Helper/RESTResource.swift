import Foundation

class RESTResource<T : Decodable> {

    let url : URL
    private(set) var state = ResourceState.empty {
        didSet {
            self.notifyObservers()
        }
    }

    private var observers = [ResourceObserver]()
    private let transformer : Transformer
    private let lock = NSRecursiveLock()

    enum ResourceState {
        case empty
        case loading(URLSessionTask)
        case loaded(T)
        case error(Error)
    }

    typealias StateObserver = (ResourceState) -> Void
    typealias ValueObserver = (T) -> Void
    typealias Transformer = (Data) throws -> T

    private struct ResourceObserver {
        weak var owner : AnyObject?
        let queue : DispatchQueue
        let observer : StateObserver
    }

    private static var defaultJSONTransformer : Transformer {
        return { data in try JSONDecoder().decode(T.self, from: data) }
    }

    init(url : URL, transformer: @escaping Transformer = defaultJSONTransformer) {
        self.url = url
        self.transformer = transformer
        load()
    }

    private func load(reload : Bool = false) {
        lock.synchronized {
            switch state {
            case .loading:
                return
            case .loaded:
                if reload {
                    fallthrough
                } else {
                    return
                }
            case .empty, .error:
                let task = createTask()
                self.state = .loading(task)
                task.resume()
            }
        }
    }

    private func notifyObservers() {
        lock.synchronized {
            debugPrint("Resource(\(url)): \(state)")
            self.observers.removeAll { observer in observer.owner == nil }
            for observer in self.observers {
                observer.queue.async {
                    observer.observer(self.state)
                }
            }
        }
    }

    func reload() {
        self.load(reload: true)
    }

    func clear() {
        self.state = .empty
    }

    func removeObservers(owner : AnyObject) {
        lock.synchronized {
            self.observers.removeAll { observer in observer.owner === owner || observer.owner == nil }
        }
    }

    func addStateObserver(owner : AnyObject, queue : DispatchQueue = .main, observeCurrent : Bool = true, observer : @escaping StateObserver) {
        lock.synchronized {
            if observeCurrent {
                observer(state)
            }
            self.observers.append(ResourceObserver(owner: owner, queue: queue, observer: observer))
        }
    }

    func addValueObserver(owner : AnyObject, queue : DispatchQueue = .main, observeCurrent : Bool = true,  observer : @escaping ValueObserver) {
        self.addStateObserver(owner: owner, queue: queue, observeCurrent: observeCurrent) { state in
            if case let .loaded(value) = state {
                observer(value)
            }
        }
    }

    private func createTask() -> URLSessionTask {
        return URLSession.shared.dataTask(with: self.url) { data, response, error in

            if let error = error {
                self.state = .error(error)
                return
            }

            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode >= 400 {
                self.state = .error(ResourceError.HTTPStatusError(status: statusCode))
            }

            guard let data = data else {
                self.state = .error(ResourceError.NoDataError)
                return
            }

            // self is captured here: while the URLSession is loading and until the notifications are delivered, the resource will be kept even if you don't hold a reference to it
            do {
                self.state = .loaded(try self.transformer(data))
            } catch let error {
                self.state = .error(error)
            }
        }
    }

    deinit {
        debugPrint("Resource(\(url)): deinit")
    }

}

enum ResourceError : Error {
    case NoDataError
    case HTTPStatusError(status : Int)
}

extension NSRecursiveLock {
    fileprivate func synchronized<T>(_ fn: () throws -> T) rethrows -> T {
        self.lock()
        defer { self.unlock() }
        return try fn()
    }
}
