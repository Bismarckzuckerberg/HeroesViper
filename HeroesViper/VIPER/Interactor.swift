//
//  Interactor.swift
//  HeroesViper
//
//  Created by Berke T. on 22.12.2021.
//

import UIKit

protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    func downloadCrypto()
}

class HeroInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    func downloadCrypto() {
        
        guard let url = URL(string: "https://api.opendota.com/api/heroStats")
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.networkFailed))
                return
            }
            do {
                let cryptos = try JSONDecoder().decode([Hero].self,from: data)
                self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
            } catch {
                self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.parsingFailed))
            }
        }
        task.resume()
    }
}


