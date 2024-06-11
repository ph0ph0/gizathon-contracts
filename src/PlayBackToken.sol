// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract PlayBackToken is ERC20, Ownable, ERC20Permit {
    address public gizaAgent;

    modifier onlyManager() {
        require(msg.sender == gizaAgent, "Caller is not gizaAgent");
        _;
    }

    constructor() ERC20("PlayBackToken", "BACK") Ownable(msg.sender) ERC20Permit("PlayBackToken") {
        gizaAgent = msg.sender;
    }

    function setGizaAgent(address addr) external onlyOwner {
        gizaAgent = addr;
    }

    function mint(address to, uint256 amount) public onlyManager {
        _mint(to, amount);
    }
}
