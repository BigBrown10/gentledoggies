// SPDX-License-Identifier: BUSL-1.1

pragma solidity ^0.8;

import ".././ONFT721.sol";
import ".././ONFT.sol";
/// @title Interface of the UniversalONFT standard
contract  GentleDoggiesSerum is ONFT {
  uint public startMintId;
    uint public immutable endMintId;
    uint public nextMintId;
    uint public maxMintId;
     bool public isMintActive;
    uint256 public cost = 0.05 ether;
    uint256 public presaleCost = 0.03 ether;
    uint256 public maxSupply = 1000;
    uint256 public maxMintAmount = 1;
    bool public paused = false;
    mapping(address => bool) public whitelisted;
    mapping(address => bool) public presaleWallets;

    constructor(string memory _name, string memory _symbol, address _layerZeroEndpoint, uint _startMintId, uint _endMintId) ONFT(_name, _symbol, _layerZeroEndpoint) {
         startMintId = _startMintId;
        endMintId = _endMintId;
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
       function setCost(uint256 _newCost) public onlyOwner {
        cost = _newCost;
    }

     function activateMint() external onlyOwner {
        isMintActive = true;
    }

    function setPresaleCost(uint256 _newCost) public onlyOwner {
        presaleCost = _newCost;
    }

    function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
        maxMintAmount = _newmaxMintAmount;
    }


    function pause(bool _state) public onlyOwner {
        paused = _state;
    }

    function whitelistUser(address _user) public onlyOwner {
        whitelisted[_user] = true;
    }

    function removeWhitelistUser(address _user) public onlyOwner {
        whitelisted[_user] = false;
    }

    function addPresaleUser(address _user) public onlyOwner {
        presaleWallets[_user] = true;
    }

    function add100PresaleUsers(address[100] memory _users) public onlyOwner {
        for (uint256 i = 0; i < 2; i++) {
            presaleWallets[_users[i]] = true;
        }
    }

    function removePresaleUser(address _user) public onlyOwner {
        presaleWallets[_user] = false;
    }

    function withdraw() public payable onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success);
    }
   
}
