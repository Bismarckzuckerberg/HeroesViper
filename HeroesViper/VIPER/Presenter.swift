//
//  Presenter.swift
//  HeroesViper
//
//  Created by Berke T. on 22.12.2021.
//

import Foundation

enum NetworkError : Error {
    case networkFailed
    case parsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? { get set }
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Hero], Error>)
}

class HeroPresenter : AnyPresenter {
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCrypto()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCrypto(result: Result<[Hero], Error>) {
        switch result {
        case .success(let hero):
            view?.update(with: hero)
        case .failure(_):
            view?.update(with: "Try again later")
        }
    }
}

