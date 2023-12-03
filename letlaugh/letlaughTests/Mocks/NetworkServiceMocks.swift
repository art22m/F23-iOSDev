import Foundation

@testable import letlaugh

final class JokesParserMock: JokesParser {
    
    // MARK: - Internal Properties
    
    var onParse: ((Data) -> Joke?)?
    
    // MARK: - Internal Methods
    
    func parse(data: Data) -> Joke? {
        return onParse?(data)
    }
    
}

final class RequestSenderMock: RequestSender {
    
    // MARK: - Internal Properties
    
    var onMakeRequest: ((URLRequest, (Result<Data, letlaugh.RequestError>) -> Void) -> Void)?
    
    // MARK: - Internal Methods
    
    func makeRequest(request: URLRequest, completion: @escaping (Result<Data, letlaugh.RequestError>) -> Void) {
        onMakeRequest?(request, completion)
    }
    
}
