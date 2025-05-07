//
// MainInteractor.swift
//
// Create by Eduardo Herrera
//

import Combine
import Foundation

// MARK: Methods of MainInteractorProtocol

class MainInteractor: MainInteractorProtocol {
  
  // MARK: - Properties and Vars

  weak var presenter: MainInteractorToPresenterProtocol?
  private let worker: MainInteractorToWorkerProtocol

  @Published private(set) var dataEntity = MainInteractorDataEntity()

  // MARK: - Lifecycle Methods

  init(worker: MainInteractorToWorkerProtocol) {
    self.worker = worker
  }

  // MARK: Private Methods

  // MARK: Public Methods

}

// MARK: - PresenterToInteractorProtocol Methods

extension MainInteractor: MainPresenterToInteractorProtocol {
  
  func onModuleLoad() {}
  func onModuleRefresh() {}
}

// MARK: - WorkerToInteractorProtocol Methods

extension MainInteractor: MainWorkerToInteractorProtocol {}
