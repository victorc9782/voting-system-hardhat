// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Voting
 * @dev Voting Platform
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract VotingSystem {

    address private _admin;
    uint numVotings;
    Voting[] private _votings;
    mapping (address => uint256) private _scores;

    struct Voting {
        string topic;
        string description;
        mapping (address => bool) votingResult;
        bool isOpen;
    }

    constructor() {
        _admin = msg.sender;
    }

    function createTopic(string memory topic, string memory description)
    external isAdmin
    returns (uint256)
    {
        Voting storage newVoting = _votings[numVotings++];
        newVoting.topic = topic;
        newVoting.description = description;
        newVoting.isOpen = false;
        _votings.push();
        return numVotings;
    }

    /**
     * @dev Check if the message sender is admin
    **/
    modifier isAdmin() {
        require(msg.sender == _admin, "Only admin can call this function");
        _;
    }
}