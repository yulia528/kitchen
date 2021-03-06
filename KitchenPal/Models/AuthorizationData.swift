//
//  AuthorizationData.swift
//  KitchenPal
//
//  Created by Nha Duong on 6/21/19.
//  Copyright © 2019 Nha Duong. All rights reserved.
//

import Foundation

struct AuthorizationData {
    var token: String = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjI2NDM1ZDA5YmQ2MmU5YjI3MTBmNzY1MjJmODYxYjkzMWY3YTIyNTQwNDNkOTMwYjczYjY1Mjg1MmFiNzI2ZDVlZjY2Nzk0Y2E4MWQ0ZWVkIn0.eyJhdWQiOiIxIiwianRpIjoiMjY0MzVkMDliZDYyZTliMjcxMGY3NjUyMmY4NjFiOTMxZjdhMjI1NDA0M2Q5MzBiNzNiNjUyODUyYWI3MjZkNWVmNjY3OTRjYTgxZDRlZWQiLCJpYXQiOjE1NTgwMDY0MTcsIm5iZiI6MTU1ODAwNjQxNywiZXhwIjoxNTg5NjI4ODE3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.rFcKNtsRZVzSyTqK7WFvB2EP7aBr3j34XXiqBle-fLLG0tzSoIVXqapw117gR8zjYACCUtIqC6XaaFezgBvPVpYDPWPci_StapI6Cts-DoHTWIfTnowsh6_CRUnXmzo-6UM78LS3QvtBnQXbvHxG7_fK1Ojl24buj_3f6GAHcFTQdoqeLYj_qmsq0Y24BofGMfs-STY57_Cvh2ntz57bc_n3HqZPRb-Cgk43ECSYNKhNgXDiAjxhaVQ6fhez3bPe0qQBpUFlgGlWdHSxan5_jb-VFv6Gp8Ays7dg7m8B-gf-phZoSjytDQcv33wwBfoQPwHCirJ_UPblYcizpA-3_tQzYIygOm2wxY5VzfUd1Szuv9O5sOUAftkfMuG42npSwIeIyjH8WVrviDI50t6VLtRbXBxrHZ9liEk9qwKN5F3xBds-a_taJdiVuk9KuGl8AR5L4L2qIlnQ1T2_-8X20zYSNHfpmlyjsmmLntLMTj1uDyq3X60puN7DwwEuHFfCPBildXsGEDtBGGuNQ6Cf0c7X1w7LRqWuY2DGJwXwDTIrOZB_TQD6vr1i68PVmzMk_UK5Z4cGZfK3O9whD24k55_9MCWl3yPVbXro0dlplJpOfUB5OiRgWKkYDvVMBZmYmNcHB_HdU-wd1MMNdbjvXusb4JbQccFrKCHfu9tPC0c"
    
    var httpHeader: [String: String] {
        return ["Authorization": token]
    }
}
