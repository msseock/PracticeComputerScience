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
    
    @Query(sort: \User.id)
    var items: [User]
    
    let totalCount: Int = 1000000

    var body: some View {
        HStack {
            Button {
                // TODO: 데이터 추가하기
                }
            } label: {
                Image(systemName: "plus")
                Text("데이터 추가하기")
            }
            .padding()
            
            Divider()
                .frame(height: 30)
            
            Button {
                // TODO: 데이터 전체 삭제
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
            }
            .onDelete { indexSet in
                // TODO: 선택한 항목 삭제하기
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: User.self, inMemory: true)
}
