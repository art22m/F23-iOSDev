import Foundation

// MARK: - Protocol

protocol ServiceAssembly { }

// MARK: - Implementation

final class ServiceAssemblyImpl: ServiceAssembly {

    private lazy var requestSender: RequestSenderImpl = {
        RequestSenderImpl()
    }()

    func makeJokesNetworkService() -> JokesNetworkServiceImpl {
        return JokesNetworkServiceImpl(
            baseUrl: "https://baneks.ru",
            parser: BaneksParser(),
            requestSender: requestSender
        )
    }
    
}
