import Foundation

enum RequestError: Error {
    
    case requestError(String)
    case serverError(String = "Server error")
    case invalidResponse(String = "Invalid response from server")
    case parseError(String = "Parse error")
    
}

protocol RequestSenderProtocol {
    func makeRequest<T: Codable>(completion: @escaping (Result<T, RequestError>) -> Void)
}

final class RequestSender: RequestSenderProtocol {
    
    private let settings: RequestSettings
    private let session: URLSession
    
    init(settings: RequestSettings, session: URLSession = URLSession.shared) {
        self.settings = settings
        self.session = session
    }
    
    func makeRequest<T: Codable>(completion: @escaping (Result<T, RequestError>) -> Void) {
        let task = session.dataTask(with: settings.request) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode >= 300 {
                completion(.failure(.serverError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse()))
                return
            }
            
            guard let result: T = self.settings.parser.parse(data: data) else {
                completion(.failure(.parseError()))
                return
            }
            
            completion(.success(result))
        }
        
        task.resume()
    }
    
}
