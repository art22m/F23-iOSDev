@testable import letlaugh
import XCTest

class JokeNetworkServiceTests: XCTestCase {

    func testRequestAndCallsCount() throws {
        // Arrange
        let jokeId = Int.random(in: 0...1000)
        let baseUrl = "tinkoff.ru"
        let fullUrl = "\(baseUrl)/\(jokeId)"
        
        let joke = Joke(name: "123", text: "456")
        
        let jokesParserMock = JokesParserMock()
        let requestSenderMock = RequestSenderMock()
        
        let networkService = JokesNetworkServiceImpl(
            baseUrl: baseUrl,
            parser: jokesParserMock,
            requestSender: requestSenderMock
        )
        
        jokesParserMock.onParse = { _ in
            return joke
        }
        
        requestSenderMock.onMakeRequest = { request, completion in
            XCTAssertEqual(request.url?.absoluteString, fullUrl)
            completion(.success(Data()))
        }
        
        // Act
        networkService.getJoke(id: jokeId) { result in
            switch result {
            case .success(let fetchedJoke):
                XCTAssertEqual(fetchedJoke, joke)
                
            case .failure(let failure):
                XCTFail("\(failure)")
            }
        }
    }
}
