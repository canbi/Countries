//
//  ImageViewModel.swift
//  MarsRoverPhotos
//
//  Created by Can Bi on 20.06.2022.
//

import Combine
import SwiftUI
import UIKit

class ImageViewModel: ObservableObject {
    // Control
    @Published var isLoading: Bool = false
    
    // Data
    @Published var image: Data? = nil
    let imageDataService: ImageDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(photo: String, id: String){
        self.imageDataService = ImageDataService(photo: photo, id: id)
        addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        imageDataService.$svgData
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
