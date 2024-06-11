// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "forge-std/StdJson.sol";
import "../../lib/forge-std/src/console2.sol";
import "../src/PlayBackToken.sol";

contract PlayBackTokenTest is Test {
    using stdJson for string;

    address public deployer;
    address public testUser;
    address public manager;
    address public payloadSigner;
    PlayBackToken public playBackToken;

    // Used to create addresses
    uint256 _addressSeed = 123456789;

    // Fork Identifiers
    uint256 public fork;

    function makeAddress(string memory label) public returns (address) {
        address addr = vm.addr(_addressSeed);
        vm.label(addr, label);
        _addressSeed++;
        return addr;
    }

    function setUp() public {
        // NOTE: You must update the fork value to the correct fork number after each deployment
        // TODO: Set blocknumber
        fork = vm.createFork(vm.envString("SEPOLIA_RPC"), 1656200);
        vm.selectFork(fork);

        testUser = makeAddress("TestUser");
        vm.deal(testUser, 1000 ether);

        deployer = makeAddress("Owner");
        vm.deal(deployer, 1000 ether);

        manager = makeAddress("Manager");
        vm.deal(manager, 1000 ether);

        vm.startPrank(deployer, deployer);

        // Deploy Token
        playBackToken = new PlayBackToken();

        playBackToken.setGizaAgent(testUser);

        vm.stopPrank();
    }

    function test_Mint() external {
        vm.startPrank(testUser);

        uint256 amount = 100;
        address recipient = 0x2dC8Bc53ECf1A59188e4c7fAB0c7bB57339F85e7;

        uint256 balBefore = playBackToken.balanceOf(recipient);
        playBackToken.mint(recipient, amount);
        uint256 balAfter = playBackToken.balanceOf(recipient);

        assertEq(balBefore + amount, balAfter);

        vm.stopPrank();
    }

    function test_SetGizaAgent() external {
        vm.startPrank(deployer);

        address gizaAgentBefore = playBackToken.gizaAgent();
        playBackToken.setGizaAgent(manager);
        address gizaAgentAfter = playBackToken.gizaAgent();

        assertEq(gizaAgentBefore, testUser);
        assertEq(gizaAgentAfter, manager);

        vm.stopPrank();
    }
}
