//
//  ContentView+SwiftData.swift
//  Apple
//
//  Created by 석민솔 on 9/13/25.
//

import SwiftData
import SwiftUI

extension ContentView {
    func addMassiveItems() async {
        do {
            print("데이터 추가작업 시작")
            // 메인 스레드에서 UI 업데이트
            await MainActor.run {
                isLoading = true
                progress = 0.0
            }

            let imageData = try await Image("canlah").exported(as: .jpeg)

            // 많은 데이터 입력
            for i in 0..<totalCount {
                let newItem = User(
                    id: i,
                    name: "user_\(i)",
                    age: Int.random(in: 10...70),
                    img: imageData
                )

                modelContext.insert(newItem)

                if i % 1000 == 0 {
                    try modelContext.save()
                    
                    // 메인 스레드에서 진행률 업데이트
                    await MainActor.run {
                        progress = Float(i) / Float(totalCount)
                    }
                }
            }

            print("데이터 추가작업 완료")
            // 메인 스레드에서 UI 업데이트
            await MainActor.run {
                isLoading = false
                progress = 1.0
            }
            
            performFetch()

        } catch {
            print("이미지 변환 불가능")
            return
        }
    }
    
    func fetchItemsIfNecessary(item: User) {
        if let lastItem = items.last, lastItem == item {
            currentPage += 1
            performFetch(currentPage: currentPage)
        }
    }
    
    func performFetch(currentPage: Int = 0) {
        var fetchDescriptor = FetchDescriptor<User>()
        fetchDescriptor.fetchLimit = 1000
        fetchDescriptor.fetchOffset = currentPage * 1000
        fetchDescriptor.sortBy = [.init(\.id, order: .forward)]
     
        do {
            self.items += try modelContext.fetch(fetchDescriptor)
        } catch {
            print(error)
        }

    }

    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }

    func deleteAllItem() {
        do {
            try modelContext.container.erase()
            try modelContext.save()
            items.removeAll()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
