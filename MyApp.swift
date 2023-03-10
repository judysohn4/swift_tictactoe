import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(macCatalyst 16.0, *) {
                NavigationStack{
                    List{
                        NavigationLink{
                            OnePlayer()
                                .navigationTitle("1 player")
                        } label : {
                            HStack{
                                Text("1 player")
                                Image(systemName:"arrow.forward.circle").font(.largeTitle)
                            }
                        }
                        NavigationLink{
                            TwoPlayer()
                                .navigationTitle("2 player")
                        } label : {
                            HStack{
                                Text("2 player")
                                Image(systemName:"arrow.forward.circle").font(.largeTitle)
                            }
                        }
                    }
                    
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
