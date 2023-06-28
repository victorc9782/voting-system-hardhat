// Right click on the script name and hit "Run" to execute
const { expect } = require("chai");
const { ethers } = require("hardhat");

async function votingSystemSetup(){
  const VotingSystem = await ethers.getContractFactory("VotingSystem");
  const votingSystem = await VotingSystem.deploy();
  await votingSystem.deployed();
  return votingSystem;
}

async function createTopic(votingSystem, topic, description){
  const newTopic = await votingSystem.createTopic(topic, description);
  return newTopic;
}
describe("VotingSystem", function () {
  it("test initial value", async function () {
    const votingSystem = await votingSystemSetup();
    console.log('Voting System deployed at:'+ votingSystem.address)

    const [owner] = await ethers.getSigners();
    expect((await votingSystem.getAdmin())).to.equal(owner.address);
  });
  it("test create voting", async function () {
    const votingSystem = await votingSystemSetup();

    const topic = "Testing Topic";
    const description = "Testing Description"
    const newVoting = (await createTopic(votingSystem, topic, description)).value;
    expect(newVoting).to.equal(0);

    const createdTopic = await votingSystem.getVotingTopic(newVoting);
    expect(createdTopic).to.equal(topic);
    
    const createdDescription = await votingSystem.getVotingDescription(newVoting);
    expect(createdDescription).to.equal(description);
  });
});