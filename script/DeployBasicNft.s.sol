//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {Script} from "../lib/forge-std/src/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script{

BasicNft basicNft;

    function run() external returns(BasicNft){
        vm.startBroadcast();
        basicNft= new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    }

}