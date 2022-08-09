//
//  Publisher.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import Combine
import SwiftUI

// https://stackoverflow.com/a/60627981
extension Publisher {
  func retryWithDelay<T, E>()
    -> Publishers.Catch<Self, AnyPublisher<T, E>> where T == Self.Output, E == Self.Failure
  {
    return self.catch { error -> AnyPublisher<T, E> in
      return Publishers.Delay(
        upstream: self,
        interval: 1.2,
        tolerance: 0.1,
        scheduler: DispatchQueue.global())
      .retry(3)
      .eraseToAnyPublisher()
    }
  }
}
