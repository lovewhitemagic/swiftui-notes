import SwiftUI

struct MonthYearSelect: View {
    @State private var selectedMonth: Int = 1
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    var onDateSelected: ((Int, Int) -> Void)?
    
    private let months = Array(1...12)
    private let years = Array(2020...2040)
    
    var body: some View {
        HStack {
            Picker("Month", selection: $selectedMonth) {
                ForEach(months, id: \.self) { month in
                    Text(String(format: "%02d", month)).tag(month)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
            
            Picker("Year", selection: $selectedYear) {
                ForEach(years, id: \.self) { year in
                    Text(String(year)).tag(year)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 100)
        }
        .onChange(of: selectedMonth) { newValue in
            onDateSelected?(newValue, selectedYear)
        }
        .onChange(of: selectedYear) { newValue in
            onDateSelected?(selectedMonth, newValue)
        }
    }
}

#Preview {
    MonthYearSelect { month, year in
        print("Selected: \(month)/\(year)")
    }
}

struct MainView: View {
    @State private var isSheetPresented = false
    @State private var selectedDate: String = ""
    
    var body: some View {
        VStack {
            Button("Select Month and Year") {
                isSheetPresented = true
            }
            .padding()
            
            Text("Selected Date: \(selectedDate)")
                .padding()
        }
        .sheet(isPresented: $isSheetPresented) {
            CustomSheetContainer {
                MonthYearSelect { month, year in
                    selectedDate = String(format: "%02d/%d", month, year)
                    isSheetPresented = false
                }
            }
            .presentationBackground(.clear)
            
            .presentationDetents([.height(350)])
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
        }
    }
}

struct CustomSheetContainer<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Select Date")
                    .font(.headline)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                        .font(.title2)
                }
            }
            .padding()
            
            content
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(.white)
        )
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    MainView()
} 