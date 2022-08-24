// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
 contract Task1{
     uint num;
     function setnum(uint _number) public{
         num =_number;
     }
     function getnum()public view returns(uint){
         return num;
     }
 }
 contract Task2{
     function setnum(uint a,uint b) public pure returns(uint){
        // uint a=20;
        // uint b=10;
         uint sum=a+b;
         uint diff= a-b;
         return(sum-diff);

     }
 }
contract Task3{
    function find(int256 a) public pure returns(int256){
        require(a>0 ,'a not be negative');
        int256 remainder = a%3;  
        return remainder;
    }
}

contract Task4{
    function average(int256 a,int256 b,int256 c) public pure returns(int256){
        require(a>0 && b>0 && c>0,'plz enter a positive number');
        int256 avg=((a+b+c)/3);
        return(avg);
    }
}
