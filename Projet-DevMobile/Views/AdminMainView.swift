//
//  AdminMainView.swift
//  Projet-DevMobile
//
//  Created by Johan Torosjan on 17/03/2023.
//

import SwiftUI

struct AdminMainView: View {
    var body: some View {
        

        VStack(alignment: .leading,spacing: 20){
                FestivalListView(isAdmin:true,benevoleIntent: nil)
        }
    }
}

struct AdminMainView_Previews: PreviewProvider {
    static var previews: some View {
        AdminMainView()
    }
}
