import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Types "./types";
import Int "mo:base/Int";
import Nat32 "mo:base/Nat32";
import Challenge "./challenge";

module {
  type UserId = Types.UserId;
  type Challenge = Challenge.Challenge;
  type ChallengeId = Challenge.ChallengeId;

  public class ChallengeDB() {
    // The "database" is just a local hash map
    let hashMap = HashMap.HashMap<ChallengeId, Challenge>(1, Challenge.isEq, Int.hash);

    // Motoko does not have random, so get creative!
    var iter = hashMap.entries();

    public func add(challenge: Challenge) {
      hashMap.put(challenge.get_id(), challenge);
    };

    public func get(challenge_id: ChallengeId): ?Challenge {
      hashMap.get(challenge_id)
    };

    public func get_any(): ?Challenge {
      if (hashMap.size() == 0) {
	return null;
      };

      var option : ?(ChallengeId, Challenge) = null;

      // Ege has faith in psuedo randomness provided by 7 iterations.
      for (j in Iter.range(0, 6)) {

        option := iter.next();

        if (Option.isNull(option)) {
          iter := hashMap.entries();
          option := iter.next();
        };
      };

      ?(Option.unwrap(option).1)
    };

    public func accepted(challenge_id: ChallengeId) {
      let challenge = Option.unwrap(hashMap.get(challenge_id));
      challenge.incr_acception_count();
      hashMap.put(challenge.get_id(), challenge);
    };

    public func completed(challenge_id: ChallengeId) {
      let challenge = Option.unwrap(hashMap.get(challenge_id));
      challenge.incr_completion_count();
      hashMap.put(challenge.get_id(), challenge);
    };
  };

  func isEq(x: ChallengeId, y: ChallengeId): Bool { x == y };
};
