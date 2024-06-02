//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {Script} from "../lib/forge-std/src/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract Interactions is Script{

    function run() external {
        address mostRecentlyDeployed =address(0x5FbDB2315678afecb367f032d93F642f64180aa3);
        mintNftonContract(mostRecentlyDeployed);
        }
    
    function mintNftonContract(address BasicNftcontract) public {
        vm.startBroadcast();
        BasicNft(BasicNftcontract).mintNft("ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json");
        vm.stopBroadcast();
    }
}
