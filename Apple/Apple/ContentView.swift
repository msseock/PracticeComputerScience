//
//  ContentView.swift
//  Apple
//
//  Created by 석민솔 on 9/11/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State var items: [User] = []
    @State var currentPage: Int = 0
    
    @State var progress: Float = 0.0
    @State var isLoading: Bool = false
    
    let totalCount: Int = 1000000

    var body: some View {
        HStack {
            Button {
                Task {
                    await addMassiveItems()
                }
            } label: {
                Image(systemName: "plus")
                Text("데이터 추가하기")
            }
            .padding()
            
            Divider()
                .frame(height: 30)
            
            Button {
                deleteAllItem()
            } label: {
                Image(systemName: "trash")
                Text("전체삭제")
            }
            .foregroundStyle(.red)
            .padding()
        }

        List {
            ForEach(items) { item in
                ListRowView(user: item)
                    .onAppear {
                        fetchItemsIfNecessary(item: item)
                    }
            }
            .onDelete { indexSet in
                deleteItems(offsets: indexSet)
            }
        }
        .listStyle(.plain)
        .onAppear {
            performFetch()
        }
        .overlay {
            if isLoading {
                ProgressView(value: progress) { Text("저장중...")}
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
