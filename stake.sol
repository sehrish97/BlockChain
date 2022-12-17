// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
contract stakeUSD{
    using SafeMath for uint256;
    struct staker{
        uint256 stakeAt;
        uint256 totalStaked;
        uint256 totalClaimed;
        uint256 lastClaimed;

    }
    mapping(address => staker) public _staked;
    IERC20 public TokenAddress; //IERC20 datatype
    uint256 reward; 
    uint256 public totalStaked;
    uint256 public totalActiveStakers;
    uint256 public apyPercentage;
    address public owner;

    constructor(address _tokenAddress, uint256 _apyPercentage){
        owner = msg.sender;
    TokenAddress = IERC20(_tokenAddress);//interface ki location ye hai(_tokenaddress)
    apyPercentage = _apyPercentage;
    }
    modifier onlyOwner(){
        require(owner==msg.sender,"only owner can execute");
        _;
    }


    function stake(uint256 amount) external {
       require(TokenAddress.balanceOf(msg.sender) > amount);
       require(_staked[msg.sender].totalStaked==0,"you are already a staker");
       TokenAddress.transferFrom(msg.sender,address(this), amount);//(address owner,address buyer,numofTokens)
       totalActiveStakers++;
       _staked[msg.sender].totalStaked += amount;
       _staked[msg.sender].stakeAt =block.timestamp;
       totalStaked += amount;
       totalActiveStakers--;
    
    }
     function unstake() external{
       require(_staked[msg.sender].totalStaked >0 ,"You are not a staker");
       TokenAddress.transfer(msg.sender,_staked[msg.sender].totalStaked);
       claim();
       totalStaked -= _staked[msg.sender].totalStaked;
       _staked[msg.sender].totalStaked= 0;
       
   }
    function rewardPool() view public returns(uint256) {
       return TokenAddress.balanceOf(address(this)) - totalStaked;
    }
    function updateAPY(uint256 _newAPY) external onlyOwner{
        apyPercentage = _newAPY;
        
    }
    function withdrawRewardPoll(uint256 amount) external onlyOwner{
        require(rewardPool()>amount, "Insufficient Reward to withdraw");
        TokenAddress.transfer(msg.sender,amount);
    }
    function claimed(address _stakee) view public returns(uint256,uint256){
        require(_staked[_stakee].totalStaked !=0,"Not  A Staker");
        uint256 claimeableDays;
        if(_staked[_stakee].lastClaimed==0){
            claimeableDays = (block.timestamp - _staked[_stakee].stakeAt).div(1 days);
        }else{
            claimeableDays = (block.timestamp - _staked[_stakee].lastClaimed).div(1 days);
        }
        uint256 perDayReward = apyPercentage.mul(_staked[_stakee].totalStaked).div(10000).div(365);
        return (claimeableDays,perDayReward.mul(claimeableDays));
        
    }
    function claim() public {
        require(_staked[msg.sender].totalStaked !=0,"NOT A STAKER");
        ( uint256 claimeabledays,uint256 claimableAmount) = claimed(msg.sender);
        require(claimableAmount != 0, "Zero Claimed");
        require(rewardPool()> claimableAmount,"Currently Reward Pool Is Empty Try A gain Later");
        TokenAddress.transfer(msg.sender, claimableAmount);
        if(_staked[msg.sender].lastClaimed == 0){
            _staked[msg.sender].lastClaimed = _staked[msg.sender].stakeAt = claimeabledays.mul(1 days);
        }
        _staked[msg.sender].lastClaimed += claimeabledays.mul(1 days);
        _staked[msg.sender].totalClaimed +=claimableAmount;
    }
    function test(address _user, uint256 _rewardDay) external{
        _staked[_user].lastClaimed = block.timestamp- _rewardDay;
    }

}
///550 se km stake nhi kr skta 
//1000 ya 1000 se km hai to package 1 
// 2000 tk package 2
//3000 tk package 3
//emergency unstake