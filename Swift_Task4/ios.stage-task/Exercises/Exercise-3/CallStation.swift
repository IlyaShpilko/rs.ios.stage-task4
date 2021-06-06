import Foundation

final class CallStation {
    var addedUsers: [User] = []
    var callsMade: [Call] = []
}

extension CallStation: Station {
    func users() -> [User] {
        return addedUsers
    }
    
    func add(user: User) {
        if addedUsers.isEmpty {
            addedUsers.append(user)
        }
        
        for i in addedUsers {
            if i == user {
                break
            }
            addedUsers.append(user)
        }
    }
    
    func remove(user: User) {
        var index = 0
        for userAtIndex in addedUsers {
            if user == userAtIndex {
                addedUsers.remove(at: index)
            }
            index += 1
        }

        if var updateUser = currentCall(user: user) {
            updateUser.status = .ended(reason: .error)
            
            var index = 0
            for userAtIndex in calls() {
                if updateUser.id == userAtIndex.id {
                    callsMade.remove(at: index)
                    callsMade.append(updateUser)
                }
                index += 1
            }
        }
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(from: let userOne, to: let userTwo):
            if users().contains(userOne) || users().contains(userTwo) {
                var call = Call(id: UUID(), incomingUser: userOne, outgoingUser: userTwo, status: .calling)

                for element in callsMade {
                    if (element.incomingUser == userTwo || element.outgoingUser == userTwo) && element.status == .talk {
                        call.status = .ended(reason: .userBusy)
                    }
                }
                
                if !(users().contains(userOne) && users().contains(userTwo)) {
                    call.status = .ended(reason: .error)
                }
                
                
                callsMade.append(call)
                
                return call.id
            }
            
        case .answer(from: let user):
            if addedUsers.contains(user) {
                var index = 0
                for element in callsMade {
                    if element.incomingUser == user || element.outgoingUser == user {
                        callsMade.remove(at: index)
                        callsMade.append(.init(id: element.id, incomingUser: element.incomingUser, outgoingUser: element.outgoingUser, status: .talk))
                        return element.id
                    }
                    index += 1
                }
            }
        case .end(from: let user):
            var index = 0
            for element in callsMade {
                if element.incomingUser == user || element.outgoingUser == user {
                    var updatedElement = element
                    
                    switch updatedElement.status {
                    case .calling:
                        updatedElement.status = .ended(reason: .cancel)
                    case.talk:
                        updatedElement.status = .ended(reason: .end)
                    case .ended(reason: _):
                        print("Error")
                    }
                    
                    callsMade.remove(at: index)
                    callsMade.append(updatedElement)
                
                    return updatedElement.id
                }
                index += 1
            }
        }
        return nil
    }
    
    func calls() -> [Call] {
        return callsMade
    }
    
    func calls(user: User) -> [Call] {
        var newArray = callsMade
        var index = 0
        for element in callsMade {
            if user == element.incomingUser || user == element.outgoingUser {
                continue
            } else {
                newArray.remove(at: index)
            }
            index += 1
        }
        return newArray
    }
    
    func call(id: CallID) -> Call? {
        for element in callsMade {
            if id == element.id || id == element.id {
                return element
            }
        }
        return nil
    }
    
    func currentCall(user: User) -> Call? {
        for element in callsMade {
            if (user == element.incomingUser || user == element.outgoingUser) && (element.status == .calling || element.status == .talk) {
                return element
            }
        }
        return nil
    }
}

