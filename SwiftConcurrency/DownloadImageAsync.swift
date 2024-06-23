//
//  DownloadImageAsync.swift
//  SwiftConcurrency
//
//  Created by Dmitrii Eselidze on 23.06.2024.
//

import SwiftUI

class DownloadImageAsyncImageLoader{
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func downloadWithEscaping(completionHandler: (_ image: UIImage?, error: Error?) ->()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else{
                    return
                }
        }
        .resume()
    }
    
}

class DownloadImageAsyncViewModel: ObservableObject{
    
    @Published var image: UIImage? = nil
    
    func fetchImage(){
        self.image = UIImage(systemName: "heart.fill")
    }
    
}

struct DownloadImageAsync: View {
    
    @StateObject private var viewModel = DownloadImageAsyncViewModel()
    
    var body: some View {
        ZStack{
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear(){
            viewModel.fetchImage()
        }
    }
}

#Preview {
    DownloadImageAsync()
}
