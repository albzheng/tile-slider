//
//  CollectionView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/5/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI


struct CollectionView: View {
    @EnvironmentObject var albumManager: AlbumManager
    
    var body: some View {
        GeometryReader {geometry in
            VStack (){
                HStack (alignment: .bottom){
                    Text ("Completed Puzzles").font(.largeTitle)
                    Star().frame(width: 40, height: 40).foregroundColor(Color.yellow)
                }.padding(.top, 20)
                if self.albumManager.collection.items.count > 0 {
                    ScrollView (.vertical) {
                        VStack {
                            ForEach (1...self.albumManager.rows, id: \.self) {row in
                                CollectionRowView(collection: self.$albumManager.collection, numCols: self.albumManager.cols, row: row, size: geometry.size)
                            }
                        }
                    }
                } else {
                    Spacer()
                }
            }
        }
    }
}


struct CollectionRowView: View {
    @Binding var collection: Collection
    let numCols: Int
    let row: Int
    var imagesInRow: Int
    let size: CGSize
    
    init (collection: Binding<Collection>, numCols: Int, row: Int, size: CGSize){
        self._collection = collection
        self.row = row
        self.numCols = numCols
        self.imagesInRow = min(collection.wrappedValue.items.count - (row-1) * numCols, numCols)
        self.size = size
    }
    
    var body : some View {
        let rowWidth = size.width
        let imageWidth = rowWidth/CGFloat(self.numCols)
        
        return HStack() {
            ForEach (1...self.imagesInRow, id: \.self) {col in
                ZStack{
                    Image(self.collection.items[Int((self.row - 1) * self.numCols) + col - 1])
                        .resizable()
                        .collectionFrame()
                }.frame(width: imageWidth * 0.8, height: imageWidth * 0.8)
            }
        }
    }
}


struct CollectionFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .border(Color(UIColor.brown), width: 3)
    }
}


extension View {
    func collectionFrame() -> some View {
        self.modifier(CollectionFrame())
    }
}


struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        return CollectionView().environmentObject(AlbumManager())
    }
}
