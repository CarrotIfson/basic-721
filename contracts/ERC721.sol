// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.2;

contract ERC721 {
    
    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(uint256 => address) private _approvals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _enabled);
    event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);
    event Transfer(address indexed from, address indexed to, uint256 indexed _tokenId);
    
    //returns numer of NFTs assigned to an owner
    function balanceOf(address owner) public view returns(uint256) {
        require(owner != address(0), "Address is 0x0");
        return _balances[owner];
    }

    function ownerOf(uint256 tokenId) public view returns(address) {
        address owner = _owners[tokenId] ;
        require(owner != address(0), "tokenId does not exists");
        return owner;
    }

    //operator functions
    // enables or disables an operator to manage all msg.senders assets
    function setApprovalForAll(address operator, bool enable) public {
        _operatorApprovals[msg.sender][operator] = enable;
        emit ApprovalForAll(msg.sender, operator, enable);
    } 

    // checks wether an address is an operator for another address
    function isApprovedForAll(address owner, address operator) public view returns (bool){
        return _operatorApprovals[owner][operator]; 
    }

    //approve functions
    // Updates an approved address for an nft
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(owner == msg.sender || isApprovedForAll(owner, msg.sender), "msg.sender is not owner o an operator");
        _approvals[tokenId] = to;   
        emit Approval(owner, to, tokenId);     
    }

    // Gets the approved address for a single NFT
    function getApproved(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "tokenId does not exist");
        return _approvals[tokenId];
    }

    //transfer functions
    // transfers ownership of an nft
    function transferFrom(address from, address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId); 
        require(
            msg.sender == owner ||
            getApproved(tokenId) == msg.sender ||
            isApprovedForAll(owner, msg.sender),
            "Msg.sender is not the owner or is not approved for transfer"
        );
        require(msg.sender == from, "from address is not the owner");
        require(to != address(0), "to address is zero");
        require(_owners[tokenId] != address(0), "tokenId does not exist");
        //clear approvals
        approve(address(0), tokenId);
        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to; 
        emit Transfer(from, to, tokenId);
    }

    // Checks if onERC721Received WHEN sending to sc
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver not implemented");
    }
    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        safeTransferFrom(from, to, tokenId, "");
    }
    // Oversimplified
    function _checkOnERC721Received() private pure returns(bool) {
        return true;
    }

    //EIP165: query if a contract implements another interface
    function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool) {
        return interfaceId == 0x80ac58cd;
    }


}