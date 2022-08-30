// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Task1{

     //..............    Task 1 Power .........
    function power(uint256 x,uint256 y)public pure returns(uint256){
        return(x**y);
    }

            //..............    Task 2 Palinderom.........

    function Palindrome(uint n)public pure returns(uint){
        uint temp;
        uint reverse=0;
        uint rem;
        temp=n; //454
        while(temp>0){ //true,true,true,false
            rem = temp%10;//4,5,4
        reverse = (reverse*10)+rem;//4,40+5=45,450+4
        temp = temp/10;//454/10,45/10,4/10

        }
        if(reverse==n){
            return 1;
        }
        else{
            return 0;
        }

    }


}