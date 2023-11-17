import Foundation

protocol JokesNetworkService {
    
    func getJoke(number: Int, completion: @escaping (Result<Joke, Error>) -> Void)
    func getRandomJoke(completion: @escaping (Result<Joke, Error>) -> Void)
    
}

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
    
    func getJoke(number: Int, completion: @escaping (Result<Joke, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/\(number)") else {
            completion(.failure(Errors.buildUrlError))
            return
        }
        
        print("DEBUG Request to \(url.absoluteString)")
        
        let request = URLRequest(url: url)
        requestSender.makeRequest(request: request) { result in // TODO: Make weak
            switch result {
            case .success(let data):
                guard let joke = self.parser.parse(data: data) else {
                    completion(.failure(Errors.parseError))
                    return
                }
                
                completion(.success(joke))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRandomJoke(completion: @escaping (Result<Joke, Error>) -> Void) {
        fatalError("not implemented")
    }
    
}
