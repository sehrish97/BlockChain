// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
 contract Tasks{
     //.............Task 1...................//
     string public str="Hello World";



     //.............Task 2...................//

     uint public number;
    function returnstatevariable() public{
        number=10;
    }

    
    function returnLocalvariable() pure public returns(uint){
        uint num=20;
        return num;
    }
 }
