import Foundation

protocol ServiceAssembly { }

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
