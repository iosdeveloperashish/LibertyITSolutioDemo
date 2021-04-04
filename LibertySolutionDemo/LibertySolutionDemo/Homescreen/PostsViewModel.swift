//
//  PostsViewModel.swift
//  LibertySolutionDemo
//
//  Created by Ashish Viltoriya on 03/04/21.
//

import Foundation
import Alamofire

class PostsViewModel {
    
    let postsURLString = "https://jsonplaceholder.typicode.com/posts"
    let postsData = Dynamic([Posts]())
    let dataError = Dynamic(false)
    
    func getPosts() {
        
        let isReachable = NetworkReachabilityManager()?.isReachable ?? false
        
        if isReachable {
            AF.request(postsURLString).response { response in
                
                guard let data = response.data else {
                    self.dataError.value = true
                    return
                }
                
                do {
                    self.savePostsData(with: data)
                    let dataArray = try JSONDecoder().decode([Posts].self, from: data)
                    self.postsData.value = dataArray
                } catch let err {
                    print(err)
                }
            }
        } else {
            self.getOfflinePosts()
        }
    }
    
    func savePostsData(with data: Data) {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL = URL(fileURLWithPath: "myFile", relativeTo: directoryURL).appendingPathExtension("txt")
        
        // Save the data
        do {
         try data.write(to: fileURL)
        } catch {
         // Catch any errors
         print(error.localizedDescription)
        }
        
    }
    
    func getOfflinePosts() {
        do {
            // Get the saved data
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = URL(fileURLWithPath: "myFile", relativeTo: directoryURL).appendingPathExtension("txt")
            let savedData = try Data(contentsOf: fileURL)
            // Convert the data back into a string
            if let savedString = String(data: savedData, encoding: .utf8) {
                let data = Data(savedString.utf8)
                do {
                    let dataArray = try JSONDecoder().decode([Posts].self, from: data)
                    self.postsData.value = dataArray
                } catch let err  {
                    print(err)
                }
                
            }
        } catch {
            // Catch any errors
            print("Unable to read the file")
        }
    }
    
}
