// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract task{
//  uint256 public prevTime= block.timestamp;
//  uint256 currentTime;


//  function getCurrentTime() public {
//      currentTime = block.timestamp;
//  }   
//  function getDiffrenceOfTime() public  view returns(uint256){
//      require(currentTime >prevTime,"Current time should be greater");
//      return  currentTime - prevTime;


// }
    struct StakerPerson {
    address stakerAddress;
    uint256 stakingAmount;
    uint256 profit;
    uint256 amountWithdrawn;
    // uint256 stakingWithdraw;
    // uint256 availableBlance;
    uint256 stakingDuration;
    }
    mapping (address => StakerPerson) public Stakers;

    constructor() payable {

    }



    function stake() payable  public {
        require(msg.value ==4 ether,"Staking amount should be 4 ether");
        if(Stakers[msg.sender].stakingAmount == 4){
            revert("you need to withdraw before staking more");
            }
        Stakers[msg.sender] = StakerPerson({
            stakerAddress : msg.sender,
            stakingAmount :msg.value,
            // stakingAmount: Stakers[msg.sender].stakingAmount+msg.value,
            profit : Stakers[msg.sender].profit,
            amountWithdrawn : Stakers[msg.sender].amountWithdrawn,
            stakingDuration : block.timestamp
        });
    }
    function withdrawn() public{
        StakerPerson memory Person = Stakers[msg.sender];
        require(Person.stakingAmount ==4,"Invalid Balance");

        uint256 currentTime=block.timestamp;
        uint256 duration = currentTime - Person.stakingDuration;
        uint256 profit;
        if(duration > 60 && duration < 120){
            profit = 1 ether;
        }
        else if(duration > 120 && duration < 180 ){
            profit= 1.5 ether;
        }
        else if(duration > 180){
            profit = 2 ether; 
        }
        (bool sent,) = payable(Person.stakerAddress).call{value: Person.stakingAmount + profit }("");
        if(!sent){
            revert("tx failed");

        }
        Stakers[msg.sender] = StakerPerson({
            stakerAddress : msg.sender,
            stakingAmount:0,
            profit : Person.profit+ profit,
            amountWithdrawn :Person.stakingAmount,
            stakingDuration : 0
        }); 
    }

}