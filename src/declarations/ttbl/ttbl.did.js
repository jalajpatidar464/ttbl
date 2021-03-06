export const idlFactory = ({ IDL }) => {
  const ChallengeId = IDL.Nat;
  return IDL.Service({
    'acceptChallenge' : IDL.Func([ChallengeId], [IDL.Text], []),
    'completeChallenge' : IDL.Func([ChallengeId], [IDL.Text], []),
    'createChallenge' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Text, IDL.Text],
        [IDL.Text],
        [],
      ),
    'createUser' : IDL.Func([IDL.Text], [IDL.Text], []),
    'displayChallenge' : IDL.Func([ChallengeId], [IDL.Text], ['query']),
    'getUser' : IDL.Func([IDL.Text], [IDL.Text], ['query']),
    'greet' : IDL.Func([IDL.Text], [IDL.Text], []),
    'learnLanguage' : IDL.Func([IDL.Text], [IDL.Text], []),
    'pickMeAChallenge' : IDL.Func([IDL.Text], [IDL.Text], []),
    'setProgress' : IDL.Func([ChallengeId, IDL.Nat], [IDL.Text], []),
    'suggestChallenge' : IDL.Func([IDL.Text, ChallengeId], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
