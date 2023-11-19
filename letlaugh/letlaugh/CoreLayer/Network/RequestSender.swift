import Foundation

// MARK: - Errors

enum RequestError: Error {
    
    case requestError(String)
    case serverError(String = "Server error")
    case invalidResponse(String = "Invalid response from server")
    
}

// MARK: - Protocol

protocol RequestSender {
    func makeRequest(request: URLRequest, completion: @escaping (Result<Data, RequestError>) -> Void)
}

// MARK: - Implementation

final class RequestSenderImpl: RequestSender {
    
    // MARK: - Private Properties
    
    private let session: URLSession
    
    // MARK: - Init
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Internal Methods
    
    func makeRequest(request: URLRequest, completion: @escaping (Result<Data, RequestError>) -> Void) {
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestError(error.localizedDescription)))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode >= 300 {
                completion(.failure(.serverError("Server error with status \(response.statusCode)")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse()))
                return
            }
            
            print("DEBUG: makeReqeust data:", data)
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
}
