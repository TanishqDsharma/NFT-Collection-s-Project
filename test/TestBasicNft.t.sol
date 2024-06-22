//SPDX-License-Identifier: MIT


pragma solidity ^0.8.16;

import {Test,console} from "../lib/forge-std/src/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";


contract TestBasicNft is Test{

    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address user = makeAddr("USER");
    uint256 public STARTING_BALANCE =10e18;

    string constant tokenUri = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";


    function setUp() public{
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
        vm.deal(user,STARTING_BALANCE);
    }

    ///////////////////////// 
    ///NFT properties ///////
    /////////////////////////

    function testNftCollectionNameisCorrect() public {
        string memory expectedName = "BasicNft";
        console.log("Expected Name of the NFT collection should be: ", expectedName);
        string memory name = basicNft.name();
        
        //Sice, we need to compare the values of two strings but we cannot compare two strings so first we need to convert
        // the values of these strings to bytes and then calculate the hash of it and then compare.
        assert(keccak256(abi.encodePacked(expectedName))==keccak256(abi.encodePacked(name)));
    }

    function testNftCollectionSymbolisCorrect() public{
        string memory expectedSymbol = "DOG";
        console.log("Expected Name of the NFT collection should be: ", expectedSymbol);
        string memory symbol = basicNft.symbol();
        assert(keccak256(abi.encodePacked(expectedSymbol))==keccak256(abi.encodePacked(symbol)));
    }

    /////////////////////
    //NFT Function Tests/
    /////////////////////

    function testMintNft() public {
        vm.prank(user);
        basicNft.mintNft(tokenUri);
        assert(basicNft.balanceOf(user)==1);
    }

    function testToGetTokenUri() public {
        vm.prank(user);
        basicNft.mintNft(tokenUri);
        string memory expectedTokenUri = tokenUri;
        vm.prank(user);
        string memory returnedTokenUri = basicNft.tokenURI(0);
        console.log("Returned Token URI is: ", returnedTokenUri);
        assert(keccak256(abi.encodePacked(expectedTokenUri))==keccak256(abi.encodePacked(returnedTokenUri)));
    }
}