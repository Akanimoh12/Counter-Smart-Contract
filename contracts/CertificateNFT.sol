// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts@4.9.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.9.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.9.3/utils/Counters.sol";

contract CertificateNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public constant MINT_FEE = 0.0001 ether;
    string public baseURI;

    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory _baseURI) ERC721("CertificateNFT", "CNFT") Ownable() {
        baseURI = _baseURI;
    }

    function mintCertificate(
        address student,
        string memory tokenURI
    ) public payable returns (uint256) {
        require(msg.value == MINT_FEE, "Must send exact minting fee of 0.0001 ETH");
        require(student != address(0), "Invalid student address");

        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _safeMint(student, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        return newTokenId;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal {
        _tokenURIs[tokenId] = _tokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return string(abi.encodePacked(baseURI, _tokenURIs[tokenId]));
    }

    function transferFrom(address, address, uint256) public pure override {
        revert("Certificates are non-transferable");
    }

    function safeTransferFrom(address, address, uint256) public pure override {
        revert("Certificates are non-transferable");
    }

    function safeTransferFrom(address, address, uint256, bytes memory) public pure override {
        revert("Certificates are non-transferable");
    }

    function withdrawFees() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No fees to withdraw");
        payable(owner()).transfer(balance);
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    
}