import SwiftUI

struct TwoPlayer: View {
    @State var turnX : Bool = true
    @State var value: String = "X"
    @State var title = "TicTacToe"
    @State var moves = ["","","","","","","","",""]
    private var ranges = [(0..<3),(3..<6),(6..<9)]
    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .bold()
                .font(.largeTitle)
            Spacer()
            ForEach(ranges, id:\.self) { range in 
                HStack{
                    ForEach(range,id:\.self) { i in XOButton(letter:$moves[i]).simultaneousGesture(TapGesture().onEnded {_ in
                        playerTap(index:i)
                    })}
                }
                Spacer()
            }
            Button("Reset") {
                reset()
            }
            .foregroundColor(.white)
            .buttonStyle(.bordered).tint(.green)
            .controlSize(.large)
            Spacer()
        }
    }
    func playerTap(index:Int) {
        if (turnX) {
            if (moves[index] == "") {
                moves[index] = "X"
                if(checkwin(letter:"X") == true) {
                    title = "player X wins!"
                }
                turnX = false
            }
        }
        else {
            if (moves[index] == "") {
                moves[index] = "O"
                if(checkwin(letter:"O")) {
                    title = "player O wins!"
                }
                turnX = true
            }
        }
    }
    func reset() {
        moves = ["","","","","","","","",""]
        turnX = true
        title = "TicTacToe"
    }
    func checkwin(letter: String) -> Bool{
        let positions = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
        
        for position in positions {
            var score = 0
            for i in position {
                if moves[i] == letter {
                    score += 1
                }
            }
            if (score == 3){
                return true
            }
        }
        return false
    }
}
