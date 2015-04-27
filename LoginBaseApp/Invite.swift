//
//  Invite.swift
//  LoginBaseApp
//
//  Created by J. Steven Welch on 4/23/15.
//  Copyright (c) 2015 True Grit Design. All rights reserved.
//

import Foundation

class Invite {
    
    func sendInvite(email:String, inviteID: String, inviteCode: String, appID:String)-> Void{
        let body=["inviteId" : inviteID, "invideCode": inviteCode, "email": email, "appId": appID, "used": false]
        let url="/v2/app/\(appID)/invite"
        CatalyzeHTTPManager.doPost(url, withParams: body as [NSObject : AnyObject], success: { (result) -> Void in
            println("Success")
            }, failure: { (result, status, error) -> Void in
                println("Failure")
        })
    }
    
    func retrieveInvite(inviteID: String, inviteCode: String, email: String, appID: String) -> Void{
        let body=["inviteId" : inviteID, "inviteCode" : inviteCode, "email" : email, "appId" : appID, "used" : false]
        let url="/v2/app/\(appID)/invite/\(inviteID)"
        CatalyzeHTTPManager.doGet(url, withParams: body as [NSObject : AnyObject], success: { (result) -> Void in
            println("Success")
            }, failure: { (result, status, error) -> Void in
                println("Failure")
        })
    }
    
    func deleteInvite(appID: String, inviteID: String){
        var body = [String: String]()
        let url="/v2/app/\(appID)/invite/\(inviteID)"
        CatalyzeHTTPManager.doDelete(url, withParams: body as [NSObject : AnyObject], success: { (result) -> Void in
            println("Success")
            }, failure: { (result, status, error) -> Void in
                println("Failure")
        })
    }
}
    