//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNft is ERC721{

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        Happy,
        Sad
    }
    mapping(uint256=>Mood) private s_tokenIdToMood;

    constructor(string memory sadSvg,string memory happySvg) ERC721("Mood NFT","MN"){
        s_tokenCounter=0;
        s_happySvgImageUri = happySvg;
        s_sadSvgImageUri = sadSvg;
    }
    

    function mintNft() public  {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] =Mood.Happy;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns(string memory){
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        
        string memory imageURI;

        if(s_tokenIdToMood[s_tokenCounter]==Mood.Happy){
            imageURI = s_happySvgImageUri;
        }else{
            imageURI = s_sadSvgImageUri;
        }
        return string(abi.encodePacked(_baseURI(),Base64.encode(
        bytes(abi.encodePacked(string.concat( '{"name":"',
        name(), // You can add whatever name here
        '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
        '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
        imageURI,
        '"}'))))));
    }
}