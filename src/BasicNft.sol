//SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;


import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract  BasicNft is ERC721 {


    constructor() ERC721("Dogie","Dog"){

    }

}