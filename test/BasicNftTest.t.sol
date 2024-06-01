//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {Test,console} from "../lib/forge-std/src/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";


contract BasicNftTest is Test{
    DeployBasicNft deployBasicNft;
    BasicNft basicNft;
    address public USER = makeAddr("user");
    
    string  public tokenUri = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testNameisCorrect() public view{
        string memory expectedName= "Dogie";
        string memory actualName= basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName))==keccak256(abi.encodePacked(actualName)));

    }

    function testCanMintandHaveABalance() public{

        vm.prank(USER);
        basicNft.mintNft(tokenUri);
        assert(basicNft.balanceOf(USER)==1);
        assert(keccak256(abi.encodePacked(tokenUri))==keccak256(abi.encodePacked(basicNft.tokenURI(0))));


    }
}