// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8;

import ".././ONFT.sol";
/// @title Interface of the UniversalONFT standard
contract  GentleDoggiesSerum is ONFT {
    uint public nextMintId;
    uint public maxMintId;
    uint256 public cost = 0.05 ether;
    uint256 public presaleCost = 0.03 ether;
    uint256 public maxSupply = 1000;
    uint256 public maxMintAmount = 1;
    bool public paused = false;
    mapping(address => bool) public whitelisted;
    mapping(address => bool) public presaleWallets;

    constructor(string memory _name, string memory _symbol, address _layerZeroEndpoint, uint _startMintId, uint _endMintId) ONFT(_name, _symbol, _layerZeroEndpoint) {
        nextMintId = _startMintId;
        maxMintId = _endMintId;
    }

    /// @notice Mint your ONFT
    function mint() external payable {
        require(nextMintId <= maxMintId, "Gentle Doggies: Max Mint limit reached");

        uint newId = nextMintId;
        nextMintId++;

        _safeMint(msg.sender, newId);
    }
      function whitelistUser(address _user) public onlyOwner {
    whitelisted[_user] = true;
  }
   
}
