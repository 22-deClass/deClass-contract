pragma solidity >= 0.4.24 <=0.8.7;


contract NFTSimple {
  string public name = "KlayLion";
  string public symbol = "KL";

  // tokenId => owner
  mapping(uint256 => address) public tokenOwner;
  // tokenId => tokenURI
  mapping(uint256 => string) public tokenURIs;

  // 소유자 토큰 리스트
  mapping(address => uint256[]) private _ownedTokens;


  // to 에게 token Id 를 발행하는데 tokenURI가 적혀있음.
  function mintWithTokenURI(address to, uint256 tokenId, string memory tokenURI) public returns (bool) {
    tokenOwner[tokenId] = to;
    tokenURIs[tokenId] = tokenURI;

    _ownedTokens[to].push(tokenId);

    return true;
  }

  function safeTransferFrom(address from, address to, uint256 tokenId) public {
    require(from == msg.sender, "KIP17: from != msg.sender");
    require(from == tokenOwner[tokenId], "KIP17: You are not the owner of the token");
    
    
    _removeTokenFromList(from, tokenId);
    _ownedTokens[to].push(tokenId);

    tokenOwner[tokenId] = to;
  }

  function _removeTokenFromList(address from, uint256 tokenId) private {
    // address = 0x1564... tokenId = 4
    // 0x1564... => [1, 4, 5, 16]
    // 0x1564... => [1, 16, 5, 16]
    uint256 lastTokenIndex = _ownedTokens[from].length - 1;
    for(uint256 i=0; i<_ownedTokens[from].length; i++) {
        if(tokenId == _ownedTokens[from][i]) {
            _ownedTokens[from][i] = _ownedTokens[from][lastTokenIndex];
            break;
        }
    }

    _ownedTokens[from].pop();
  }

  function ownedTokens(address owner) public view returns (uint256[] memory) {
    return _ownedTokens[owner];
  }

  function setTokenUri(uint256 id, string memory uri) public {
    tokenURIs[id] = uri;
  }

  function balanceOf(address owner) public view returns (uint256) {
    // 소유자 validation
    require( owner != address(0), "KIP17: balance query for the zero address" );

    return _ownedTokens[owner].length;
  }   

  function burn(address owner, uint256 tokenId) public {
    safeTransferFrom(owner, address(0), tokenId);
  }
}