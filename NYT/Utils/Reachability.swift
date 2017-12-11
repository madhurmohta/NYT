
import Foundation
import SystemConfiguration

///Provide the  Network availability check

open class Reachability {

  
    class func isConnectedToNetwork() -> (Bool, Bool) {

        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        var isConnectionTypeCellular: Bool = false
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return (false, false)
        }
        var flags = SCNetworkReachabilityFlags.connectionAutomatic
        if (SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == false) {
            return (false, isConnectionTypeCellular)
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        if isReachable {
            isConnectionTypeCellular = (flags.contains(.isWWAN))
        }

        return ((isReachable && !needsConnection), isConnectionTypeCellular)
    }
}
