pragma solidity ^0.4.23;

import "../math/SafeMath.sol";

contract CumulativeBallot {
    using SafeMath for uint256;

    string public constant title = "Cummulative Voting Ballot";

    uint256 public maxPersonVotes;

    struct Voter {
        uint256 votes;
    }

    struct Proposal {
        uint256 voteCount;
    }

    address chairperson;
    mapping(address => Voter) voters;
    Proposal[] proposals;

    /// Create a new ballot with $(_numProposals) different proposals.
    constructor(uint8 _numProposals, uint256 _maxVotes) public {
        chairperson = msg.sender;
        maxPersonVotes = _maxVotes;
        proposals.length = _numProposals;
    }

    /// Add max votes for person
    /// May only be called by $(chairperson).
    function addVotes(uint256 _votes) public {
        if (msg.sender != chairperson) {
          return;
        }

        maxPersonVotes = maxPersonVotes.add(_votes);
    }

    /// Give votes to proposal $(_toProposal).
    function vote(uint8 _toProposal, uint256 _votes) public {
        require(_toProposal < proposals.length);

        Voter storage sender = voters[msg.sender];

        require(sender.votes.add(_votes) < maxPersonVotes);
      
        sender.votes = sender.votes.add(_votes);
        proposals[_toProposal].voteCount += proposals[_toProposal].voteCount.add(_votes);
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