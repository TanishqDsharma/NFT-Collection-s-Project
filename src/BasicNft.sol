// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.16;

// Using openzeppilin package ERC721 contract
import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {

    // This token counter will represent token id that NFT will be having
    uint256 private s_tokenCounter;

    // This mapping will map tokenId with a tokenUri
    mapping(uint256 => string) private s_tokenIdtoUri;
    
    constructor()ERC721("BasicNft","DOG") {
        // when we deploy our contract we want this counter to start from zero
        s_tokenCounter = 0 ;
    }


    //////////////////////////////////
    //Public and external Functions///
    //////////////////////////////////


    /**
     * 
     * @param tokenURI Pass your tokenUri
     */
    function mintNft(string memory tokenURI) public {
        s_tokenIdtoUri[s_tokenCounter] = tokenURI;
        _safeMint(msg.sender,s_tokenCounter);
        s_tokenCounter++;
    }


    ////////////////////////////////////////
    //Public and external view Functions///
    //////////////////////////////////////

    /**
     * 
     * @param tokenId Pass the tokenId for which you want the tokenUri
     * @notice Whenever we want to look what an NFT looks like we will call the tokenUri function
     */
    function tokenURI(uint256 tokenId) public view override returns(string memory){
        return s_tokenIdtoUri[tokenId];
    }



}