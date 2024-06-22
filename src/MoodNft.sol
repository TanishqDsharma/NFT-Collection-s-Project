// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "../lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract MoodNft is ERC721{

    ////////// 
    //ERRORS//
    ////////// 

    error MoodNft_CantFlipIfNotOwner();

    //This will keep track of token Id generated
    uint256 private s_tokenCounter;

    string private s_sadSvgUri;
    string private s_happySvgUri;

    enum Mood{
        HAPPY,
        SAD
    }

    //Mapping to map tokenId with the mood
    mapping(uint256=>Mood) private s_tokenIdToMood;

    /**
     * 
     * @param sadSvgUri The image uri of the SadSvg 
     * @param happySvgUri  The image uri of the HappySvg 
     */
    constructor(string memory sadSvgUri, string memory happySvgUri) ERC721("Mood NFT","MN") {
        s_tokenCounter=0;
        s_sadSvgUri=sadSvgUri;
        s_happySvgUri=happySvgUri;

    }

    /////////////////////////// 
    //////Internal Function//// 
    /////////////////////////// S

    // This function returns the strings to baseURI string 
    function _baseURI() internal pure override returns(string memory){
        return "data:application/json;base64,";
    }



    //////////////////////////
    //public & external func//
    /////////////////////////

   
    // This function will mint the NFT token
    function mintNft() public {
        _safeMint(msg.sender,s_tokenCounter);
        //When an NFT get Minted default the NFT mood to HAPPY
        s_tokenIdToMood[s_tokenCounter]=Mood.HAPPY;
        s_tokenCounter++;
    }

    /**
     * 
     * @param tokenId The Id of the ERC721 token
     * @notice This function will flip the mood of the NFT for example if the mood is happy this function will change it sad
     */

     function flipmood(uint256 tokenId) public{
        //Only want NFT owner to change the mood

       if(!_isApprovedOrOwner(msg.sender,tokenId)){
        revert MoodNft_CantFlipIfNotOwner();
       }

        if(s_tokenIdToMood[tokenId]==Mood.HAPPY){
            s_tokenIdToMood[tokenId]==Mood.SAD;
        }else{
            s_tokenIdToMood[tokenId]==Mood.HAPPY;
        }
    }


    /**
     * 
     * @param tokenId The Id of the ERC721 token
     * @notice This function returns the tokenURI of the ERC721 token, A token URI returns all the metadata related to the NFT.
     */

    function tokenURI(uint256 tokenId) public view override returns(string memory){

        string memory imageURI;

        if(s_tokenIdToMood[tokenId]==Mood.HAPPY){
            imageURI = s_happySvgUri;
        }else{
            imageURI = s_sadSvgUri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                        abi.encodePacked(
                            '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}