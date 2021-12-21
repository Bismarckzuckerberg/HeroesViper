//
//  Router.swift
//  HeroesViper
//
//  Created by Berke T. on 22.12.2021.
//
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class HeroRouter : AnyRouter {
    var entry: EntryPoint?
    static func startExecution() -> AnyRouter {
        let router = HeroRouter()
        var view : AnyView = HeroViewController()
        var presenter : AnyPresenter = HeroPresenter()
        var interactor : AnyInteractor = HeroInteractor()
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.entry = view as? EntryPoint
        return router
    }
    
}
