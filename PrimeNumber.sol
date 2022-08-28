// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Task{
    function primeNumber(uint256 n)public pure returns(string memory){
        uint256 i;
        require(n>2,"Enter a number greater than 2");
        for (i = 2; i <= n/2; ++i) {
    if (n % i == 0) {
        return "Not a prime number";
    }else{
        return "A prime number";
            }
        }
    }
}