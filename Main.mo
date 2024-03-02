import HashMap "mo:base/HashMap";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Text "mo:base/Text";

actor TheExAndPtMetaverse {
	public shared (send__msg) func send(amount : Nat, reciever : Principal) : async Bool {
		let node__2052_success = do {
			let node__2052_balance = Option.get(balanceMap.get(send__msg.caller), 0);
			let node__2052_amount = amount;
			if (node__2052_balance >= node__2052_amount) {
				balanceMap.put(send__msg.caller, node__2052_balance - node__2052_amount);
				balanceMap.put(reciever, Option.get(balanceMap.get(reciever), 0) + node__2052_amount);
				true
			} else {
				false
			}
		};
		return node__2052_success;
	};
	
	public func getBalance(user : Principal) : async Nat {
		return Option.get(balanceMap.get(user), 0);
	};
	
	public func share(text : Text) : async Nat32 {
		textLookup.put(Text.hash(text), text);
		return Text.hash(text);
	};
	
	public query func get(id : Nat32) : async ?Text {
		return textLookup.get(id);
	};
	
	var balanceMap : HashMap.HashMap<Principal, Nat> = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);
	balanceMap.put(Principal.fromText("2vxsx-fae"), 1000);
	
	var textLookup : HashMap.HashMap<Nat32, Text> = HashMap.HashMap<Nat32, Text>(0, Nat32.equal, func (x) {x});
}
