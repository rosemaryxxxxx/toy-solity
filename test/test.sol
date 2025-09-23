// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HelloWorld {
    bool boolVar_1 = true;
    bool boolVar_2 = false;

    uint256 unitVar = 257;

    int256 intVar = -1;

    bytes32 bytesVar = "Hello World";

    string strVar = "Hello World";

    struct Info {
        string phrase;
        uint256 id;
        address addr;
    }

    Info[] infos;

    mapping(uint256 => Info) infoMapping;

    address addrVar = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function sayHello(uint256 _id) public view returns (string memory) {
        // for(uint256 i = 0; i < infos.length; i++){
        //     if(infos[i].id == _id){
        //         return addInfo(infos[i].phrase);
        //     }
        // }
        // return addInfo(strVar);

        //mapping方式
        if(infoMapping[_id].addr == address(0x0)){
            return "not found";
        }else{
            return addInfo(infoMapping[_id].phrase);
        }
    }  

    function setHelloWorld(string memory newString, uint256 _id) public {
        // strVar = newString;
        // 数组方式
        Info memory info = Info(newString, _id, msg.sender);
        // infos.push(info);
        //mapping方式
        infoMapping[_id] = info;
    }

    function addInfo(string memory helloWorldStr) internal pure returns (string memory) {
        return string.concat("rosemary says: " , helloWorldStr );
    }

}
 