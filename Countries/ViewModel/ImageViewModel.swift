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
    var imageSubscription: AnyCancellable?
    
    init(photo: String, id: String){
        self.imageDataService = ImageDataService(photo: photo, id: id)
        self.addSubscribers()
        self.imageDataService.getImage()
        self.isLoading = true
    }
    
    private func addSubscribers(){
        imageSubscription = imageDataService.$svgData
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            }
    }
}
