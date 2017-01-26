pragma solidity ^0.4.4;

contract Schedule {
    struct Proposal
    {
      string name;   // short name (up to 32 bytes)
      uint monday; // number of accumulated votes
      uint tuesday; // number of accumulated votes
      uint wednesday; // number of accumulated votes
      uint thursday; // number of accumulated votes
      uint friday; // number of accumulated votes
    }

    address public chairperson;
    mapping(address => bool) public voters;
    Proposal[] public proposals;
    uint numVoters;

    function Schedule() {
      chairperson = msg.sender;
      numVoters = 1;
    }
    
    function getProposalName(uint proposalID) constant returns (string){
        return proposals[proposalID].name;
    }
    function getProposalCount() constant returns (uint){
        return proposals.length;
    }
    
    function newProposal (string name) {
        Proposal memory p;
        p.name = name; 
        proposals.push(p);
    }
    
    function numOfPeople () constant returns (uint){
        return numVoters;
    }
    
    function getVoteCount(uint proposalID, uint day) constant returns (uint){
        Proposal p = proposals[proposalID];
        if(proposalID == 1){
            return proposals[proposalID].monday;
        }
        else if(proposalID == 2){
            return proposals[proposalID].tuesday;
        }
        else if(proposalID == 3){
            return proposals[proposalID].wednesday;
        }        
        else if(proposalID == 4){
            return proposals[proposalID].thursday;
        }        
        else if(proposalID == 5){
            return proposals[proposalID].monday;
        }
        return 0;
    }
    
    function addMember(address addr){
        if(msg.sender != chairperson){
            throw;
        }
        voters[addr] = true;
        numVoters++;
    }
    
    function removeMember(address addr){
        if(msg.sender != chairperson) {
            throw;
        }
        voters[addr] = false;
        numVoters--;
    }
    

    function vote(uint proposalID, uint day) {
        if(voters[msg.sender] == false){
            throw;
        }
        if( day == 1){
            proposals[proposalID].monday++;
        }
        else if( day == 2){
            proposals[proposalID].tuesday++;
        }
        
        else if( day == 3){
            proposals[proposalID].wednesday++;
        }
        
        else if( day == 4){
            proposals[proposalID].thursday++;
        } 
        else if (day == 5) {
            proposals[proposalID].friday++;
        }
    }

}
