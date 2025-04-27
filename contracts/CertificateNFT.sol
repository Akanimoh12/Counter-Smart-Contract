// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract CertificateNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public mintFee = 0.001 ether; // Minting fee (adjust as needed)

    struct Certificate {
        string name;
        string category;
        string imageURI;
        address recipient;
        address minter;
        uint256 timestamp;
    }

    mapping(uint256 => Certificate) public certificates;
    mapping(address => uint256[]) public userCertificates; // Track NFTs by minter

    event CertificateMinted(
        uint256 indexed tokenId,
        string name,
        string category,
        string imageURI,
        address indexed recipient,
        address indexed minter,
        uint256 timestamp
    );

    constructor() ERC721("CertificateNFT", "CNFT") Ownable() {}

    function mintCertificate(
        string memory name,
        string memory category,
        string memory imageURI,
        address recipient
    ) public payable returns (uint256) {
        require(msg.value >= mintFee, "Insufficient minting fee");
        require(recipient != address(0), "Invalid recipient address");

        // Transfer mint fee to owner
        (bool sent, ) = owner().call{value: msg.value}("");
        require(sent, "Failed to send mint fee");

        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _safeMint(recipient, newTokenId);
        _setTokenURI(newTokenId, imageURI);

        certificates[newTokenId] = Certificate(
            name,
            category,
            imageURI,
            recipient,
            msg.sender,
            block.timestamp
        );

        // Track certificate by minter
        userCertificates[msg.sender].push(newTokenId);

        emit CertificateMinted(
            newTokenId,
            name,
            category,
            imageURI,
            recipient,
            msg.sender,
            block.timestamp
        );

        return newTokenId;
    }

    function getCertificate(uint256 tokenId) public view returns (Certificate memory) {
        require(_exists(tokenId), "Token does not exist");
        return certificates[tokenId];
    }

    function getUserCertificates(address user) public view returns (uint256[] memory) {
        return userCertificates[user];
    }

    function updateMintFee(uint256 newFee) public onlyOwner {
        mintFee = newFee;
    }

    // Fallback function to receive ETH
    receive() external payable {}
}