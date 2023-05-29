//
//  ContentView.swift
//  PhotoRandom
//
//  Created by MacBook Pro on 29/05/2023.
//

import SwiftUI

class ViewModel: ObservableObject{
    @Published var image : Image?
    
    func fetchNewImage(){
        guard let url = URL(string: "https://random.imagecdn.app/500/150")
        
        else{
            return
        }
        let task =  URLSession.shared.dataTask(with: url) { data, _ , _ in
            guard let data = data else{return}
            DispatchQueue.main.async {
                guard  let uiImage = UIImage(data:data) else{return}
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
   @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                if let image = viewModel.image{
                    image
                        .resizable()
                        .foregroundColor(Color.pink)
                        .frame(width: 200,height: 200)
                        .padding()
                }else{
                    Image(systemName: "Photo")
                        .resizable()
                        .foregroundColor(Color.pink)
                        .frame(width: 200,height: 200)
                        .padding()
                }
                
                Spacer()
                Button(action: {
                    viewModel.fetchNewImage()
                }, label:{
                    Text("New Image")
                        .bold()
                        .frame(width: 250,height: 55)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                })
                
            }
            .navigationTitle("Photo Mania")
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
