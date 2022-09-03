// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Task{
// Create a function reverseArray(array, length of array) . This reverseArray() will take two arguments - a dynamic uint type array and length of the array.
// The reverseArray() will reverse the array. For Example - If array =[2,5,9,11,1] then reverseArray() will return [1,11,9,5,2] If array =[90,20,30,10] then reverseArray() will return [10,30,20,90]
// Note - Function will be public.

function reverseArray(uint[] memory arr)public pure  returns(uint[]memory){
     uint[] memory temp=new uint[](arr.length);
   uint j;
     for(uint i=arr.length;i>0;i--){
         temp[j] = arr[i-1];
         j++;
     }
     return temp;
}

function sort(uint[] memory arr) public pure returns(uint[] memory){
    // uint[] memory temp=new uint[](arr.length);

    uint length =arr.length;
    for(uint i=0;i<=length -1;i++){
        for(uint j=0;j<length-1;j++){
            if(arr[j]>arr[j+1]){
                uint current_value=arr[j];
                arr[j]=arr[j+1];
                arr[j+1]=current_value;

            }
        }
    }
    return arr;
}
}