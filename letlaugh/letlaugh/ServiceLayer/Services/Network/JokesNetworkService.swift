import Foundation

// MARK: Protocol

protocol JokesNetworkService: AnyObject {
    
    func getNextJoke(completion: @escaping (Result<Joke, Error>) -> Void)
    func getJoke(id: Int, completion: @escaping (Result<Joke, Error>) -> Void)
    
}

// MARK: Implementation

final class JokesNetworkServiceImpl: JokesNetworkService {
    
    // MARK: - Private Types
    
    private enum Errors: Error {
        
        case buildUrlError
        case parseError
        
    }
    
    // MARK: - Private Properties
    
    private let baseUrl: String
    private let parser: JokesParser
    private let requestSender: RequestSender
    
    // MARK: - Init
    
    init(baseUrl: String, parser: JokesParser, requestSender: RequestSender) {
        self.baseUrl = baseUrl
        self.parser = parser
        self.requestSender = requestSender
    }
    
    // MARK: - Internal Methods
    
    func getNextJoke(completion: @escaping (Result<Joke, Error>) -> Void) {
        let id = AppData.lastJokeID + 1
        getJoke(id: id, completion: completion)
        AppData.lastJokeID = id
    }
    
    func getJoke(id: Int, completion: @escaping (Result<Joke, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/\(id)") else {
            completion(.failure(Errors.buildUrlError))
            return
        }
        
        let request = URLRequest(url: url)
        requestSender.makeRequest(request: request) { [weak self] result in
            switch result {
            case .success(let data):
                guard let joke = self?.parser.parse(data: data) else {
                    completion(.failure(Errors.parseError))
                    return
                }
                
                completion(.success(joke))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
