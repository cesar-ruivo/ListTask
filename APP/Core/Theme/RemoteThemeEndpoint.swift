import Foundation

struct ThemeEndpoint: EndPoint {
    var baseURL: URL? {
        return URL(string: "https://gist.githubusercontent.com/cesar-ruivo/53fc060661d2cc3d6174f27e4d649e5a/raw(apagar)/c48b31e1b089b4a37c5079f0d22273d021c76eeb/theme.json")
    }
    
    var path: String { return "" }
    
    var method: HTTPMethod { return .get }
    
    var parameters: [String : Any]? { return nil }
}
