import SwiftUI

struct XOButton: View {
    @Binding var letter : String
    @State var degrees: Double = 0.0

    var body: some View {
        ZStack {
                Circle()
                    .frame(width:120,height:120)
                    .foregroundColor(.white)
            
            if letter == "X" {
                Circle()
                    .frame(width:100, height:100)
                    .foregroundColor(.blue)
            } else if letter == "O" {
                Circle()
                    .frame(width:100, height:100)
                    .foregroundColor(.orange)
            } else {
                Circle()
                    .frame(width:100,height:100)
                    .foregroundColor(.yellow)
            }
                Text(letter)
                    .font(.system(size:50))
                    .fontWeight(.bold)
   
        }
        .rotation3DEffect(.degrees(degrees), axis:(x:0.0, y: 1.0, z:0.0))
        .simultaneousGesture(TapGesture().onEnded({_ in withAnimation {
            self.degrees -= 180
        }
            
        }))
    }
}

struct XOButton_Previews: PreviewProvider{
    static var previews: some View {
        XOButton(letter:.constant("X"))
    }
}
