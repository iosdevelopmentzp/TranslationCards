
import Foundation

protocol ServiceError: BaseError {
    var serviceName: String { get }
}
