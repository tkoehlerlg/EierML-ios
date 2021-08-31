//
//  AddEggView.swift
//  EierML-ios
//
//  Created by Torben Köhler on 17.08.21.
//

import SwiftUI

struct AddEggView: View {
    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject private var model: EggsViewModel

    @State private var widthValue: Double = 0.55
    @State private var heightValue: Double = 0.6
    @State private var viscosityPickerValue: Int = 4
    private var viscosity: Int {
        // swiftlint:disable:next computed_accessors_order
        set { viscosityPickerValue = newValue - 1 }
        get { viscosityPickerValue+1 }
    }

    init(model: EggsViewModel) {
        self._model = ObservedObject(wrappedValue: model)
    }

    // ViscosityView
    @State var showViscosityView: Bool = true

    init(
        model: EggsViewModel,
        egg: Egg
    ) {
        self._model = ObservedObject(wrappedValue: model)
        self.viscosity = egg.viscosity
    }

    var body: some View {
        GeometryReader { reader in
            ZStack {
                NavigationView {
                    VStack {
                        Spacer()
                        Image("egg")
                            .renderingMode(.template)
                            .resizable()
                            .frame(
                                width: CGFloat(widthValue)*reader.size.width,
                                height: CGFloat(heightValue)*reader.size.height/1.4
                            )
                            .foregroundColor(.white)
                            .gradientForeground(colors: [
                                Color.Palette.blue,
                                Color.Palette.red
                            ])
                        .frame(width: reader.size.width, height: reader.size.height/2)
                        Spacer()
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Höhe: \(eggHeightInMilimeter(screenSize: reader.size))mm")
                                .font(.body)
                            Slider(
                                value: $heightValue,
                                in: 0.2...1,
                                minimumValueLabel: Image(systemName: "minus"),
                                maximumValueLabel: Image(systemName: "plus")
                            ) {
                                EmptyView()
                            }
                            .padding(.bottom, 15)
                            Text("Breite: \(eggWidthInMilimeter(screenSize: reader.size))mm")
                                .font(.body)
                            Slider(
                                value: $widthValue,
                                in: 0.2...1,
                                minimumValueLabel: Image(systemName: "minus"),
                                maximumValueLabel: Image(systemName: "plus")
                            ) {
                                EmptyView()
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        Spacer().frame(height: 30)
                    }
                    .navigationBarItems(leading: quitButton, trailing: continueButton(screenSize: reader.size))
                }
            }
        }
    }

    private var quitButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Abbrechen")
                .fontWeight(.medium)
        })
    }

    private func continueButton(screenSize: CGSize) -> some View {
        NavigationButton {
            ViscosityView(
                number: model.eggs.count+1,
                height: eggWidthInMilimeter(screenSize: screenSize),
                width: eggHeightInMilimeter(screenSize: screenSize),
                model: model
            )
        } label: {
            Text("Weiter")
                .fontWeight(.bold)
        }
    }

    private func eggWidthInMilimeter(screenSize: CGSize) -> Int {
        let pixel = CGFloat(widthValue)*screenSize.width
        let centimeter = getCentimeterForNormalPixels(pixel)
        return Int((centimeter*10).rounded())
    }

    private func eggHeightInMilimeter(screenSize: CGSize) -> Int {
        let pixel = CGFloat(heightValue)*screenSize.height/1.4
        let centimeter = getCentimeterForNormalPixels(pixel)
        return Int((centimeter*10).rounded())
    }

    private func getCentimeterForNormalPixels(_ pixels: CGFloat) -> CGFloat {
        let nativeBoundsComposer = UIScreen.main.nativeBounds.width/UIScreen.main.bounds.width
        let nativeBounds = pixels*nativeBoundsComposer

        return nativeBounds/(UIScreen.pixelsPerCentimeter ?? 1)
    }

    private func getNormalPixelsForCentimeter(_ centimeter: CGFloat) -> CGFloat {
        let nativeBounds = centimeter*(UIScreen.pixelsPerCentimeter ?? 1)
        let nativeBoundsComposer = UIScreen.main.nativeBounds.width/UIScreen.main.bounds.width

        return nativeBounds/nativeBoundsComposer
    }
}

struct AddEggView_Previews: PreviewProvider {
    static var previews: some View {
        AddEggView(model: EggsViewModel())
        AddEggView(model: EggsViewModel())
            .previewDevice("iPod touch (7th generation)")
    }
}

//Egg(
//    number: model.eggs.count+1,
//    height: eggWidthInMilimeter(screenSize: screenSize),
//    width: eggHeightInMilimeter(screenSize: screenSize),
//    viscosity: viscosity
//)
