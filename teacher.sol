// SPDX-License-Identifier:MIT

pragma solidity 0.8.0;

contract Staking {
    uint256 public _current_time = block.timestamp;

    // PERSON WHO STAKE HIS ETHRES
    struct StakerPerson {
        address stakerAddress;
        uint256 stakingAmount;
        uint256 profit ;
        uint256 ammountWithdrawn; // earns from here
        uint256 stakingDuration;
    }

    mapping(address => StakerPerson) public Stakers;

    constructor() payable {

    }


    function stake() payable public {
        require(msg.value == 4 ether, "Staking amount should be 4 ether");
        if(Stakers[msg.sender].stakingAmount == 4 ether){
            revert("you need to withdraw before staking more");
        }


        Stakers[msg.sender] = StakerPerson({
            stakerAddress : msg.sender,
            stakingAmount : msg.value,
            profit : Stakers[msg.sender].profit,
            ammountWithdrawn : Stakers[msg.sender].ammountWithdrawn,
            stakingDuration : block.timestamp
        });
    }

   


}