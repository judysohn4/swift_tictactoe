import SwiftUI

struct OnePlayer: View {
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
                print("got here")
            }
            .foregroundColor(.white)
            .buttonStyle(.bordered).tint(.green)
            .controlSize(.large)
            Spacer()
        }
        }
    func playerTap(index:Int) {
        if (moves[index] == "") {
            moves[index] = "X"
            if(checkwin(letter:"X") == true) {
                print("checkwin")
                title = "player X wins!"
                return
            }
        } else {
            return
        }
        let position = computerTurn()
        print(position)
        if position == -1 {
            if(checkwin(letter:"O")) {
                title = "player O wins !"
                return
            } else if (checkwin(letter:"X")) {
                title = "player X wins !"
                return
            } else {
                title = "draw"
                return 
            }
        }
        if (moves[position] == "") {
            moves[position] = "O"
            if(checkwin(letter:"O")) {
                title = "player O wins!"
            }
        }
    }
    
    func computerTurn() -> Int {
        
        //O
        for i in stride(from: 0, to: moves.count-2, by: 1) {
            if(moves[i] == "O" && moves[i+1] == "O" && moves[i+2] == "") {
                return i+2 
            }
            if(moves[i] == "O" && moves[i+1] == "" && moves[i+2] == "O"){
                return i+1
            }
            if(moves[i] == "" && moves[i+1] == "O" && moves[i+2] == "O") {
                return i
            }
        }
        for i in stride(from: 0, to: moves.count-6, by:3) {
            if(moves[i] == "O" && moves[i+3] == "O" && moves[i+6] == "") {
                return i+6
            }
            if(moves[i] == "O" && moves[i+3] == "" && moves[i+6] == "O"){
                return i+3
            }
            if(moves[i] == "" && moves[i+3] == "O" && moves[i+6] == "O")
                {
                return i
            }
        }
        for i in stride(from:0, to: moves.count-8, by:4) {
            if(moves[i] == "" && moves[i+4] == "O" && moves[i+8] == "O") {
                return i 
            }
            if(moves[i] == "O" && moves[i+4] == "" && moves[i+8] == "O") {
                return i+4
            }
            if(moves[i] == "O" && moves[i+4] == "O" && moves[i+8] == "") {
                return i+8
            }
        }
        for i in stride(from:0, to: moves.count-6, by:2) {
            if(moves[i] == "" && moves[i+2] == "O" && moves[i+4] == "O") {
                return i 
            }
            if(moves[i] == "O" && moves[i+2] == "" && moves[i+4] == "O") {
                return i+2
            }
            if(moves[i] == "O" && moves[i+2] == "O" && moves[i+4] == "") {
                return i+4
            }
        }
        
        // X
        //across
        for i in stride(from: 0, to: moves.count-2, by: 3) {
            if(moves[i] == "X" && moves[i+1] == "X" && moves[i+2] == "") {
                return i+2 
            }
            if(moves[i] == "X" && moves[i+1] == "" && moves[i+2] == "X"){
                return i+1
            }
            if(moves[i] == "" && moves[i+1] == "X" && moves[i+2] == "X") {
                return i
            }
        }
        //column
        for i in stride(from: 0, to: moves.count-6, by:1) {
            if(moves[i] == "X" && moves[i+3] == "X" && moves[i+6] == "") {
                return i+6
            }
            if(moves[i] == "X" && moves[i+3] == "" && moves[i+6] == "X"){
                return i+3
            }
            if(moves[i] == "" && moves[i+3] == "X" && moves[i+6] == "X")
            {
                return i
            }
        }
        //left to right diagnal
        for i in stride(from:0, to: moves.count-8, by:4) {
            if(moves[i] == "" && moves[i+4] == "X" && moves[i+8] == "X") {
                return i 
            }
            if(moves[i] == "X" && moves[i+4] == "" && moves[i+8] == "X") {
                return i+4
            }
            if(moves[i] == "X" && moves[i+4] == "X" && moves[i+8] == "") {
                return i+8
            }
        }
        //right to left diagnal 
        for i in stride(from:2, to: moves.count-6, by:1) {
            if(moves[i] == "" && moves[i+2] == "X" && moves[i+4] == "X") {
                return i 
            }
            if(moves[i] == "X" && moves[i+2] == "" && moves[i+4] == "X") {
                return i+2
            }
            if(moves[i] == "X" && moves[i+2] == "X" && moves[i+4] == "") {
                return i+4
            }
        }
        
        if moves[4] == "" {
            return 4
        } else if moves[0] == "" {
            return 0
        } else if moves[2] == "" {
            return 2
        }else if moves[6] == "" {
            return 6
        } else if moves[8] == "" {
            return 8
        } else {
            var num = 0
            for move in moves {
                if move == "" {
                    print(move)
                    return num
                } else {
                    num+=1
                }
            }
        }
            return -1
    }
    
    func reset() {
        moves = ["","","","","","","","",""]
        title = "TicTacToe"
    }
    func checkwin(letter: String) -> Bool{
        print("checkwin1")
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
