// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Voting System
 * @dev Voting Platform
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract VotingSystem {

    address private _admin;
    uint256 numVotings = 0;
    Voting[] private _votings;
    mapping (address => uint256) private _scores;

    struct Voting {
        string topic;
        string description;
        bool[] yesAddresses;
        bool[] noAddresses;
        bool isOpen;
    }

    constructor() {
        _admin = msg.sender;
    }

    function createTopic(string memory _topic, string memory _description)
    external isAdmin
    returns (uint256)
    {
        bool [] memory yesAddresses;
        bool [] memory noAddresses;
        _votings.push(Voting(_topic, _description, yesAddresses , noAddresses, false));
        return numVotings++;
    } 

    /** 
     * @dev Return value 
     * @return value of '_admin'
     */
    function getAdmin()
    public view 
    returns (address)
    {
        return _admin;
    }

    
    /** 
     * @dev Return value 
     * @return value of 'topic' by voting index
     */
    function getVotingTopic(uint256 num)
    public view 
    returns (string memory)
    {
        return _votings[num].topic;
    }
    
    /** 
     * @dev Return value 
     * @return value of 'description' by voting index
     */
    function getVotingDescription(uint256 num)
    public view 
    returns (string memory)
    {
        return _votings[num].description;
    }

    /**
     * @dev Check if the message sender is admin
    **/
    modifier isAdmin() {
        require(msg.sender == _admin, "Only admin can call this function");
        _;
    }
}