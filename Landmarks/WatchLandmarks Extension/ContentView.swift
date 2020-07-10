/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that presents the contents of the watchOS app's root view.
*/

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
    for _ in 0...count-3 {
        updates.append(20)
    }
    
    updates.append(10)
    updates.append(0)
    updates.append(0)

   return updates
}

func initPaddingBottomMap(count: Int)->[Int]
{
    var updates: [Int] = []
    for _ in 0...count-3 {
        updates.append(-40)
    }
    
    updates.append(-20)
    updates.append(0)
    updates.append(0)
    
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
    var userData: UserData
    
    var count: Int = UserData().landmarks.count
    
    @State var x: [CGFloat] = initX(count: UserData().landmarks.count)
    
    @State var dragIsActivate: Bool = false
    
    
    
    @State var shadowMap: [Int] = initShadowMap()
    @State var paddingMap: [Int] = initPaddingMap(count: UserData().landmarks.count)
    @State var paddingBottomMap: [Int] = initPaddingBottomMap(count: UserData().landmarks.count)
    
    
    
    var body: some View {
    
        print(UserData().landmarks.count)
    return ZStack{
         ForEach(1..<count, id: \.self){
         i in
            MainCard(index: i)
                 .offset(y: self.x[i])
                 .gesture((DragGesture()
                 
                 .onChanged({(value) in
                     
                     self.dragIsActivate = true
                     
                     if self.x[i] > 50{
                         self.x[i] = 170
                        
                         self.paddingMap[i - 1] = 0
                         self.paddingMap[i - 2] = 10
                         self.paddingMap[i - 3] = 20
                         
                         self.paddingBottomMap[i - 1] = 0
                         self.paddingBottomMap[i - 2] = -20
                         self.paddingBottomMap[i - 3] = -40
  
                     }else if self.x[i] < -50{
                         self.x[i] = -170
                        
                         self.paddingMap[i - 1] = 0
                         self.paddingMap[i - 2] = 10
                         self.paddingMap[i - 3] = 20
                         
                         self.paddingBottomMap[i - 1] = 0
                         self.paddingBottomMap[i - 2] = -20
                         self.paddingBottomMap[i - 3] = -40
                        
                     }else{
                         self.x[i] = value.translation.height
                     }
                 })
                 
                     .onEnded({
                         (value) in
                         
                         self.dragIsActivate = false
                         
                         if self.x[i] == 170 || self.x[i] == -170 {
                             
                         }else{
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
   
    /*struct cardSlider_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList { WatchLandmarkDetail(landmark: $0) }
            .environmentObject(UserData())
        
    }*/
    
}


struct ContentView: View {
    
    var body: some View {
        cardSlider(userData: UserData())
    }

}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList { WatchLandmarkDetail(landmark: $0) }
            .environmentObject(UserData())
        
    }
}*/
