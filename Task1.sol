// SPDX-License-Identifier: GPL-3.0
   
pragma solidity >=0.7.0 <0.9.0;


// contract Deposit {
//     mapping (address => uint256) depositors;
//    // mapping (time => uint256) 
//     //uint counter;
//     uint public start;


//     constructor() {
//        // counter = 0;
//        start =block.timestamp;

//     }
//     function deposit() public payable {
//         require(msg.value >= 1 ether,"The minimum amount entered should be 1 ether");
//         depositors[msg.sender] += msg.value;
//     }

//     function recieve() external  payable {
//         deposit();
//     }

//     function withdrawal() public {
//         require(depositors[msg.sender] > 0,"You have not deposited any ether");
//         if(block.timestamp>=start + 5 seconds) {
//             payable(msg.sender).transfer((depositors[msg.sender] / 100) + 90);
//         }
//         else if(block.timestamp>=start + 2 minutes) {
//             payable(msg.sender).transfer((depositors[msg.sender] / 100) + 80);
//         }
//         else if(block.timestamp>=start + 15 seconds ) {
//             payable(msg.sender).transfer((depositors[msg.sender] / 100) + 70);
//         }
//         depositors[msg.sender] = 0;
//     }
// }


contract invest {

    struct User {
        uint256 invested_amount;
        uint256 profit;
        uint256 profit_withdrawn;
        uint256 start_time;
        uint256 exp_time;
        bool time_started;
    }

    mapping(address => User) public invest_map;

    function invest_fun() public payable {
        require(msg.value >= 0, "Please Enter Amount more than 0");
        if (invest_map[msg.sender].time_started == false) {
            invest_map[msg.sender].start_time = block.timestamp;
            invest_map[msg.sender].time_started = true;
            invest_map[msg.sender].exp_time = block.timestamp + 30 days;
        }
        invest_map[msg.sender].invested_amount += msg.value;
        invest_map[msg.sender].profit += ( (msg.value * 1 * 30 ) / (1000));
}
function current_profit() public view returns (uint256) {
    uint256 local_profit;
    if (block.timestamp <= invest_map[msg.sender].exp_time) {
        if ( (((invest_map[msg.sender].profit + invest_map[msg.sender].profit_withdrawn) * (block.timestamp - invest_map[msg.sender].start_time)) / (30 * (1 days))) > invest_map[msg.sender].profit_withdrawn ) {
            local_profit = (((invest_map[msg.sender].profit + invest_map[msg.sender].profit_withdrawn) * (block.timestamp - invest_map[msg.sender].start_time)) / (30 * (1 days))) - invest_map[msg.sender].profit_withdrawn; 
            return local_profit;
        } else {
            return 0;
        }
    }
    if (block.timestamp > invest_map[msg.sender].exp_time) {
        return invest_map[msg.sender].profit;
    }
}
function withdraw_profit() public payable returns(bool){
        uint256 current_profit = current_profit();
        invest_map[msg.sender].profit_withdrawn = invest_map[msg.sender].profit_withdrawn + current_profit;
        invest_map[msg.sender].profit = invest_map[msg.sender].profit - current_profit;
        payable(msg.sender).transfer(current_profit);
        return true;
}
}
