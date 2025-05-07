//
// MainWorker.swift
//
// Create by Eduardo Herrera
//

import Combine

// MARK: Methods of MainWorkerProtocol

class MainWorker: MainWorkerProtocol {
  
  // MARK: - Properties and Vars

  weak var interactor: MainWorkerToInteractorProtocol?

  // MARK: - Lifecycle Methods

  init() {}
}

// MARK: - InteractorToWorkerProtocol Methods

extension MainWorker: MainInteractorToWorkerProtocol {}

