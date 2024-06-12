// Get balance// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console2.sol";
import "../src/PlayBackToken.sol";

// forge script script/setGizaAgent.s.sol:SetGizaAgent --rpc-url https://eth-sepolia.g.alchemy.com/v2/_yLxTeW4JJan3E71O5UcDqg6B4o-vlqO -vvvv
contract SetGizaAgent is Script {
    function run() external {
        uint256 deployerPrivKey = vm.envUint("PK1");
        address playbackToken = vm.envAddress("PLAYBACK_TOKEN");

        vm.startBroadcast(deployerPrivKey);

        PlayBackToken pT = PlayBackToken(playbackToken);
        pT.setGizaAgent(0xb06Dea0B663C9AB9B0FFC6145E6Ff81DfBe370f3);

        vm.stopBroadcast();
    }
}
