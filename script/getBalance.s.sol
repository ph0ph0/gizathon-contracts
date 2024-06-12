// Get balance// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console2.sol";
import "../src/PlayBackToken.sol";

// forge script script/getBalance.s.sol:GetUserBalance --rpc-url https://eth-sepolia.g.alchemy.com/v2/_yLxTeW4JJan3E71O5UcDqg6B4o-vlqO -vvvv --optimize --optimizer-runs 200
contract GetUserBalance is Script {
    function run() external {
        uint256 deployerPrivKey = vm.envUint("PK1");
        address playbackToken = vm.envAddress("PLAYBACK_TOKEN");

        vm.startBroadcast(deployerPrivKey);

        PlayBackToken pT = PlayBackToken(playbackToken);
        address recipient = 0x2dC8Bc53ECf1A59188e4c7fAB0c7bB57339F85e7;

        // Recipient balance before
        uint256 balance = pT.balanceOf(recipient);
        console2.log("Balance:", balance);

        vm.stopBroadcast();
    }
}
