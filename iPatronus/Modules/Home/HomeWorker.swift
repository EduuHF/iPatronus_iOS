//
// HomeWorker.swift
//
// Create by Eduardo Herrera
//

import Combine

// MARK: Methods of HomeWorkerProtocol

class HomeWorker: HomeWorkerProtocol {
  
  // MARK: - Properties and Vars

  weak var interactor: HomeWorkerToInteractorProtocol?

  // MARK: - Lifecycle Methods

  init() {}
}

// MARK: - InteractorToWorkerProtocol Methods

extension HomeWorker: HomeInteractorToWorkerProtocol {
  
  func fetchCharacterList() {
    
    let resource = FetchCharacterListResource()
    APIClient.shared.perform(resource) { result in
      switch result {
      case .success(let dataList):
        self.interactor?.onFetchCharacterListSuccess(dataList: dataList)
      case .failure(let error):
        self.interactor?.onFetchCharacterListFail(error: error)
      }
    }
  }
}

