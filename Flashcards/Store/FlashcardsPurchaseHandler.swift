import Foundation
import StoreKit

class FlashcardsPurchaseHandler : NSObject, SKPaymentTransactionObserver {

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for tx in transactions {
            switch (tx.transactionState) {

            case .purchased:
                unlock(productId: tx.payment.productIdentifier)
                queue.finishTransaction(tx)

            case .restored:
                unlock(productId: tx.original!.payment.productIdentifier)
                queue.finishTransaction(tx)

            case .failed:
                NSLog("%@", "Payment Queue Error: \(String(describing: tx.error))")
                queue.finishTransaction(tx)

            case .purchasing: break   // do nothing
            case .deferred:   break   // do nothing
            }
        }
    }

    func unlock(productId : String) {
        NSLog("Unlock %@", productId)

        switch (productId) {
        case "FLASHCARDS_CAPITALS":
            let model = FlashcardsModel.shared
            model.createCard(frontText: "Deutschland", backText: "Berlin")
            model.createCard(frontText: "Frankreich", backText: "Paris")
            model.createCard(frontText: "Italien", backText: "Rom")
            model.save()
        default:
            NSLog("Unknown product ID: %@", productId)
        }
    }
    func register() {
        SKPaymentQueue.default().add(self)
    }
}
