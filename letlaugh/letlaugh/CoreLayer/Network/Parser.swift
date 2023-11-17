import Foundation

protocol Parser {
    
    func parse<T>(data: Data) -> T?
    
}
