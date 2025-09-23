// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//{ HelloWorld }指导入合约，不加{ HelloWorld }则是导入文件，
import { HelloWorld } from "./test.sol";

// 可以通过url从互联网导入合约
// import { HelloWorld } from "https://x/test.sol";

contract HelloWorldFactory {
    HelloWorld hw; 

    HelloWorld[] hws;

    function createHelloWorld() public {
        hw = new HelloWorld();
        hws.push(hw);
    }

    function getHelloWorldByIndex(uint256 _index) public view returns(HelloWorld){
        return hws[_index];
    }

    function callSayHelloFromFactory(uint256 _index, uint256 _id) 
        public
        view 
        returns(string memory){
            return hws[_index].sayHello(_id); 
    }

    function callSetHelloWorldFromFactory(uint256 _index, string memory newString, uint256 _id) public {
        hws[_index].setHelloWorld(newString, _id);
    }
    
}