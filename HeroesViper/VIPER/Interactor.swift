//
//  Interactor.swift
//  HeroesViper
//
//  Created by Berke T. on 22.12.2021.
//

import UIKit

protocol AnyInteractor {
    var presenter : AnyPresenter? {get set}
    func downloadHero()
}

class HeroInteractor : AnyInteractor {
    var presenter: AnyPresenter?
    func downloadHero() {
        
        guard let url = URL(string: "https://api.opendota.com/api/heroStats")
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidDownloadHero(result: .failure(NetworkError.networkFailed))
                return
            }
            do {
                let heroes = try JSONDecoder().decode([Hero].self,from: data)
                self?.presenter?.interactorDidDownloadHero(result: .success(heroes))
            } catch {
                self?.presenter?.interactorDidDownloadHero(result: .failure(NetworkError.parsingFailed))
            }
        }
        task.resume()
    }
}


