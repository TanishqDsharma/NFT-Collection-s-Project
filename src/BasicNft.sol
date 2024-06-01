//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;


import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract  BasicNft is ERC721 {

    uint256 private s_tokenCounter;
    
    constructor() ERC721("Dogie","Dog"){
        s_tokenCounter =0;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        
    }

    

}