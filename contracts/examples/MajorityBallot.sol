pragma solidity ^0.4.23;

import "../math/SafeMath.sol";

contract MajorityBallot {
    using SafeMath for uint256;

    string public constant title = "Majority Voting Ballot";

    struct Voter {
        bool voted;
    }

    struct Proposal {
        uint256 voteCount;
    }

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    /// Create a new ballot with $(_numProposals) different proposals.
    constructor(uint8 _numProposals) public {
        chairperson = msg.sender;
        proposals.length = _numProposals;
    }

    function isVoted() public constant returns (bool) {
        Voter storage sender = voters[msg.sender];
        
        return sender.voted;
    }

    /// Give a single vote to proposal $(_toProposal).
    function vote(uint8 _toProposal) public {
        require(_toProposal < proposals.length);

        Voter storage sender = voters[msg.sender];

        require(!sender.voted);
      
        sender.voted = true;
        proposals[_toProposal].voteCount += proposals[_toProposal].voteCount.add(1);
    }

    /// Show a winning proposal
    function winningProposal() public constant returns (uint8 _winningProposal) {
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++)
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
    }

    /// Show votes for proposal
    function showProposalVotes(uint8 _prop) public constant returns (uint256 _votes) {
      require(_prop < proposals.length);

      _votes = proposals[_prop].voteCount;
    }
}