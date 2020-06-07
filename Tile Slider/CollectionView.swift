//
//  CollectionView.swift
//  Tile Slider
//
//  Created by Albert Zheng on 6/5/20.
//  Copyright © 2020 Albert Z. All rights reserved.
//

import SwiftUI

/*
struct CollectionView: View {
    @ObservedObject var albumManager: AlbumManager
    
    var body: some View {
        VStack (){
            Text ("Completed Puzzles").font(.largeTitle).padding(.top, 20)
            ScrollView (.vertical) {
                ZStack {
                    ForEach (1...albumManager.rows, id: \.self) {row in
                        CollectionRowView(collection: self.$albumManager.collection, numCols: self.albumManager.cols, row: row)
                    }
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
    
    init (collection: Binding<Collection>, numCols: Int, row: Int){
        self._collection = collection
        self.row = row
        self.numCols = numCols
        self.imagesInRow = min(collection.wrappedValue.items.count - (row-1) * numCols, numCols)
        print(self.imagesInRow)
    }
    
    var body : some View {
        GeometryReader {geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        let rowWidth = size.width
        let imageWidth = rowWidth/CGFloat(self.numCols)
        
        return ZStack {
            ForEach (1...self.imagesInRow, id: \.self) {col in
                //Text(self.collection.items[Int((self.row - 1) * self.numCols) + col - 1])
                Image(self.collection.items[Int((self.row - 1) * self.numCols) + col - 1])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth * 0.8, height: imageWidth * 0.8)
                    .position(x: imageWidth * 0.6 + imageWidth * CGFloat(0.9*Float(col-1)), y: imageWidth * 0.5 + imageWidth * 0.9 * CGFloat(self.row - 1))
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        let collection = Collection()
        let albumManager = AlbumManager(collection: collection)
        return CollectionView(albumManager: albumManager)
    }
}
*/

struct CollectionView: View {
    @EnvironmentObject var albumManager: AlbumManager
    
    var body: some View {
        GeometryReader {geometry in
            VStack (){
                Text ("Completed Puzzles").font(.largeTitle).padding(.top, 20)
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
                //Text(self.collection.items[Int((self.row - 1) * self.numCols) + col - 1])
                ZStack{
                    Rectangle().foregroundColor(Color.gray)
                    Image(self.collection.items[Int((self.row - 1) * self.numCols) + col - 1])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.position(x: imageWidth * 0.6 + imageWidth * CGFloat(0.9*Float(col-1)), y: imageWidth * 0.5 + imageWidth * 0.9 * CGFloat(self.row - 1))
                }.frame(width: imageWidth * 0.8, height: imageWidth * 0.8)
            }
        }
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        return CollectionView().environmentObject(AlbumManager())
    }
}
