//
//  ImageDataService.swift
//  MarsRoverPhotos
//
//  Created by Can Bi on 20.06.2022.
//

import Foundation
import SwiftUI
import Combine

class ImageDataService {
    @Published var svgData: Data? = nil
    
    private var imageSubscription: AnyCancellable?
    
    private let photo: String
    private let fileManager: LocalFileManagerImage = .instance
    private let imageName: String
    
    init(photo: String, id: String) {
        self.photo = photo
        self.imageName = id
    }
}

// MARK: - Functions
extension ImageDataService {
    func getImage() {
        if let savedImage = fileManager.getImage(name: imageName) {
            svgData = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: photo) else { return }
        
        imageSubscription = NetworkingManager.download(url: url, loadingStatus: .constant(false))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                guard let self = self else { return }
                self.svgData = returnedData
                self.imageSubscription?.cancel()
                let result = self.fileManager.saveImage(svgImage: returnedData, name: self.imageName)
                print(result)
            })
    }
}
