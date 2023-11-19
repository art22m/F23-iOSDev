import Foundation

// MARK: Protocol

protocol ServiceAssembly { }

// MARK: Implementation

final class ServiceAssemblyImpl: ServiceAssembly {

    private lazy var requestSender: RequestSenderImpl = {
        RequestSenderImpl()
    }()

    func makeJokesNetworkService() -> JokesNetworkService {
        return JokesNetworkServiceImpl(
            baseUrl: "https://baneks.ru",
            parser: BaneksParser(),
            requestSender: requestSender
        )
    }
    
    func makeJokesStorageService(storageManager: StorageManager) -> JokesStorageService {
        return JokesStorageServiceImpl(
            storageManager: storageManager
        )
    }
    
}
