import Foundation

// MARK: Protocol

protocol ServiceAssembly { }

// MARK: Implementation

final class ServiceAssemblyImpl: ServiceAssembly {
    
    // MARK: - Private Properties
    
    private lazy var requestSender: RequestSenderImpl = {
        RequestSenderImpl()
    }()
    
    private let storageManager: StorageManager
    
    // MARK: - Init
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
    
    // MARK: - Internal Methods

    func makeJokesNetworkService() -> JokesNetworkService {
        return JokesNetworkServiceImpl(
            baseUrl: "https://baneks.ru",
            parser: BaneksParser(),
            requestSender: requestSender
        )
    }
    
    func makeJokesStorageService() -> JokesStorageService {
        return JokesStorageServiceImpl(
            storageManager: storageManager
        )
    }
    
}
