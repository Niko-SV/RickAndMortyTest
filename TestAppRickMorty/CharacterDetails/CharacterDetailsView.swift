//
//  CharacterDetailsViewController.swift
//  TestAppRickMorty
//
//  Created by NikoS on 01.06.2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @ObservedObject var viewModel: CharacterDetailsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: viewModel.image)) { image in
                image
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: Style().cornerRadius))
            } placeholder: {
                ProgressView()
            }
            .ignoresSafeArea(edges: .top)
            .aspectRatio(1, contentMode: .fit)
            .accessibilityIdentifier("DetailsImage")
            
            HStack {
                VStack(alignment: .leading, spacing: Style().speciesAndGenderHStackSpacer) {
                    Text(viewModel.name)
                        .font(.system(size: Style().nameTextFontSize))
                        .accessibilityIdentifier("DetailsName")
                    
                    HStack(spacing: Style().hStackSpacer) {
                        Text(viewModel.species)
                            .foregroundColor(Style().speciesTextColor)
                            .accessibilityIdentifier("DetailsSpecies")
                        Circle()
                            .fill(Style().circleColor)
                            .frame(width: Style().circleSize, height: Style().circleSize)
                        Text(viewModel.gender)
                            .foregroundColor(Style().genderTextColor)
                            .accessibilityIdentifier("DetailsGender")
                    }
                }
                
                Spacer()
                
                Text(viewModel.status)
                    .font(.system(size: Style().statusTextFontSize))
                    .foregroundStyle(.white)
                    .padding(.horizontal, Style().horizontalStatusTextPaddings)
                    .padding(.vertical, Style().verticalStatusTextPaddings)
                    .background(Style().statusRoundedRectangleColor)
                    .clipShape(Capsule())
                    .offset(y: Style().statusTextOffset)
                    .accessibilityIdentifier("DetailsStatus")
            }
            .padding()
            
            HStack(spacing: Style().hStackSpacer) {
                Text(AppConstants.detailsScreenLocationText)
                    .foregroundColor(Style().locationTitleTextColor)
                Text(viewModel.location)
                    .foregroundColor(Style().locationTextColor)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Style().customBackButtonForegroundColor)
                        .padding(.horizontal, Style().customBackButtonPaddings)
                        .padding(.vertical, Style().customBackButtonPaddings)
                        .background(Style().customBackButtonBackgroundColor)
                        .clipShape(Circle())
                }
                .accessibilityIdentifier("DetailsBackButton")
            }
        }
    }
}
