import Foundation

final class ThemeHost {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = .init()) {
        self.networkService = networkService
    }
    
    //MARK: - funcoes
    func fetchRemoteTheme(completion: @escaping (AppTheme?) -> Void) {
        let endpoint: ThemeEndpoint = ThemeEndpoint()
        
        networkService.request(endPoint: endpoint) { (result: Result<AppTheme, Error>) in
            switch result {
            case .success(let remoteTheme):
                completion(remoteTheme)
                print("Tema remoto carregado com sucesso!")
                
            case .failure(let error):
                print("Falha ao buscar tema remoto: \(error). Carregando tema local.")
                self.loadLocalTheme(completion: completion)
            }
        }
    }
    
    func loadLocalTheme(completion: @escaping (AppTheme?) -> Void) {
        guard let bundle: URL = Bundle.main.url(forResource: "theme", withExtension: "json") else {
                    print("ERRO: theme.json não encontrado.")
                    completion(nil)
                    return }
        
        do {
            let themeData: Data = try Data(contentsOf: bundle)
            let theme: AppTheme = try JSONDecoder().decode(AppTheme.self, from:  themeData)
            
            completion(theme)
            print("Tema carregado com sucesso!")
            
        } catch {
            print("Algo deu errado: \(error)")
            completion(nil)
        }
    }
}
