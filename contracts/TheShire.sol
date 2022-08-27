pragma solidity ^0.8.2;

import "./ERC721.sol";

contract TheShireInhabitants is ERC721 {
    string public name; // ERC721 Metadata
    string public symbol; // ERC721 Metadata
    uint256 public tokenCount;

    mapping(uint256 => string) private _tokenURIs;
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    // returns an URL that points to the metadata
    function tokenURI(uint256 tokenId) public view returns (string memory) { // ERC721 Metadata
        return _tokenURIs[tokenId];
    }

    function tokenURI(uint256 _tokenId) public view returns (string) {
        require(_owners[_tokenId]!=address(0), "non-existant tokenId");
        return Strings.strConcat(
            baseTokenURI(),
            Strings.uint2str(_tokenId)
        );
    }

    // creates a new NFT in the collection
    function mint(string memory _tokenURI) public {
        tokenCount += 1; //tokenId
        _balances[msg.sender] += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
    }
    
    function supportsInterface(bytes4 interfaceId) public pure override returns (bool) {
        return interfaceId == 0x80ac58cd || interfaceId == 0x5b5e139f;
    }
    // supportsInterface
}