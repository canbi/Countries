//
//  ImageView.swift
//  MarsRoverPhotos
//
//  Created by Can Bi on 20.06.2022.
//

import SVGView
import SwiftUI

struct ImageView: View {
    @StateObject var vm: ImageViewModel
    
    init(photo: String, id: String) {
        self._vm = StateObject(wrappedValue: ImageViewModel(photo: photo, id: id))
    }
    
    var body: some View {
        Group {
            if let image = vm.image {
                SVGView(data: image)
                
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height:200, alignment: .center)
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(photo: "", id: "")
    }
}
