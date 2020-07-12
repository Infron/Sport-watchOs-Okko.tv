import SwiftUI

struct MainCard: View {
    
    var index: Int
    
    var body: some View {
                
        ZStack {
             Rectangle()
                .fill(Color.purple)
            .frame(height: 115)
            .cornerRadius(15)
                
            Text(UserData().landmarks[index].name)
                .font(.largeTitle)
                .bold()
                .colorMultiply(Color.black)
        }
    }
}

func initPaddingMap(count: Int)->[(Int)]
{
    var updates: [Int] = []
    
    if count >= 3 {
        for _ in 0...count-3 {
            updates.append(20)
        }
        
        updates.append(10)
        updates.append(0)
        updates.append(0)
    }else if count == 2{
        for _ in 0...count-2 {
            updates.append(10)
        }
        
        updates.append(0)
    }else if count == 1 {
        for _ in 0...count-1 {
            updates.append(20)
        }
        updates.append(10)
    }
    
    

   return updates
}

func initPaddingBottomMap(count: Int)->[Int]
{
    var updates: [Int] = []
    
    if count >= 3{
        for _ in 0...count-3 {
            updates.append(-40)
        }
        
        updates.append(-20)
        updates.append(0)
        updates.append(0)
    }else if count == 2{
        for _ in 0...count-2 {
            updates.append(-20)
        }
        
        updates.append(0)
    }else if count == 1{
        for _ in 0...count-1 {
            updates.append(-40)
        }
        
        updates.append(-20)
    }
    
   return updates
}

func initShadowMap()->[(Int)]
{
    let updates = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8]
    
   return updates
}

func initX(count: Int)->[(CGFloat)]{
    var updates: [CGFloat] = []
    
    for _ in 0...count{
        updates.append(0)
    }
    
    return updates
}



struct cardSlider: View {
    var count: Int = UserData().landmarks.count
    
    @State var x: [CGFloat] = initX(count: UserData().landmarks.count)
    
    @State var dragIsActivate: Bool = false
    
    @State var shadowMap: [Int] = initShadowMap()
    @State var paddingMap: [Int] = initPaddingMap(count: UserData().landmarks.count)
    @State var paddingBottomMap: [Int] = initPaddingBottomMap(count: UserData().landmarks.count)
    
    var body: some View {
        
    return ZStack{
         ForEach(0..<count, id: \.self){
         i in
            MainCard(index: i)
                 .offset(y: self.x[i])
                 .gesture((DragGesture()
                 
                 .onChanged({(value) in
                     
                     self.dragIsActivate = true
                     
                     if self.x[i] > 50{
                         
                        if (i+1 == 1){
                        }else{
                            self.x[i] = 170
                        }
                        
                        if(i+1 == 2){
                            self.paddingMap[i - 1] = 0
                            self.paddingBottomMap[i - 1] = 0
                        }else if (i+1 == 3){
                            self.paddingMap[i - 1] = 0
                            self.paddingMap[i - 2] = 10
                            
                            self.paddingBottomMap[i - 1] = 0
                            self.paddingBottomMap[i - 2] = -20
                        }else if(i+1 > 3){
                            self.paddingMap[i - 1] = 0
                            self.paddingMap[i - 2] = 10
                            self.paddingMap[i - 3] = 20
                            
                            self.paddingBottomMap[i - 1] = 0
                            self.paddingBottomMap[i - 2] = -20
                            self.paddingBottomMap[i - 3] = -40
                        }
  
                     }else if self.x[i] < -50{
                            if (i+1 == 1){
                            }else{
                                self.x[i] = -170
                            }
                        
                        if(i+1 == 2){
                            self.paddingMap[i - 1] = 0
                            self.paddingBottomMap[i - 1] = 0
                        }else if (i+1 == 3){
                            self.paddingMap[i - 1] = 0
                            self.paddingMap[i - 2] = 10
                            
                            self.paddingBottomMap[i - 1] = 0
                            self.paddingBottomMap[i - 2] = -20
                        }else if(i+1 > 3){
                            self.paddingMap[i - 1] = 0
                            self.paddingMap[i - 2] = 10
                            self.paddingMap[i - 3] = 20
                            
                            self.paddingBottomMap[i - 1] = 0
                            self.paddingBottomMap[i - 2] = -20
                            self.paddingBottomMap[i - 3] = -40
                        }
                        }else{
                            self.x[i] = value.translation.height
                        }
                 }).onEnded({
                         (value) in
                         
                         self.dragIsActivate = false
                         
                         if self.x[i] == 170 || self.x[i] == -170 {
                            
                         }
                         else{
                             self.x[i] = 0
                         }
                 })))
                 .animation(.spring())
                 .padding(.bottom, CGFloat(self.paddingBottomMap[i]))
                 .shadow(radius: /*self.dragIsActivate ? CGFloat(self.shadowMap[i]) : 0*/ 8)
                 .padding(CGFloat(self.paddingMap[i]))
         }
    
        }
    }
}


struct ContentView: View {
    @State var scrollAmount = 0.0
    
    var body: some View {
        cardSlider()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList { WatchLandmarkDetail(landmark: $0) }
            .environmentObject(UserData())
        
    }
}
