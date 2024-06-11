// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console2.sol";
import "../src/PlayBackToken.sol";

// forge script script/Deploy.s.sol:DeployScript --rpc-url "https://eth-sepolia.g.alchemy.com/v2/_yLxTeW4JJan3E71O5UcDqg6B4o-vlqO" -vvvv --optimize --optimizer-runs 200 --legacy
contract DeployScript is Script {
    function run() external {
        // deploy vision contract
        // update oracle contract whitelist so vision contract can call it

        // Get the privKey from the env var testnet values
        address deployer = vm.envAddress("PK1_ADDRESS");
        uint256 deployerPrivKey = vm.envUint("PK1");

        // // Tell F to send txs to the BC
        vm.startBroadcast(deployerPrivKey);

        // Deploy PlayBackToken
        PlayBackToken playBackToken = new PlayBackToken();
        // Output the contract address for ease of access!
        console2.log("playBackToken contract address", address(playBackToken));

        // Set the token address in the signedMinter contract
        // playBackToken.setGizaAgent(address(playBackToken));
        console2.log("deployerAddress", deployer);

        vm.stopBroadcast();
    }
}
