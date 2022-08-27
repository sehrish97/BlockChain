// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Task1{
    function digitsum(uint _num) public pure returns(uint){
        uint total=0;
        while(_num >0){
            uint num2=_num % 10;
            total = total + num2;
            _num =_num /10;
        }
        return total;
    }
}
contract Task2{
    function nthTerm(uint256 n,uint256 a,uint256 b,uint256 c) public pure returns (uint256) {
        uint256[100] memory arr;
        uint256 i;
        arr[1] = a;
        arr[2] = b;
        arr[3] = c;
for (i = 4; i <= n; i++) {
           arr[i]= arr[i];
           arr[i] = arr[i - 1] + arr[i - 2] + arr[i - 3];
       }
        return arr[n];
    }
}
