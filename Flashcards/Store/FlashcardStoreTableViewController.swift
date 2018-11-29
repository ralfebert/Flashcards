import UIKit
import StoreKit

class FlashcardStoreTableViewController: UITableViewController, SKProductsRequestDelegate {

    private var request : SKProductsRequest!
    private var products : [SKProduct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.request = SKProductsRequest(productIdentifiers: Set(["FLASHCARDS_CAPITALS"]))
        self.request.delegate = self
        self.request.start()
    }

    @IBAction func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadCell", for: indexPath)
        let product = products[indexPath.row]

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale

        cell.textLabel?.text = product.localizedTitle
        cell.detailTextLabel?.text = numberFormatter.string(from: product.price)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    // MARK: - SKProductsRequestDelegate

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        self.tableView.reloadData()
        self.request = nil
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        NSLog("%@", error as NSError)
        self.request = nil
    }

}
