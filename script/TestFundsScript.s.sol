// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "forge-std/Test.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";


contract TestFundsScript is Script, Test {

    address my_address = vm.envAddress("MY_ADDRESS");
    address c3t_1_address = vm.envAddress("C3T_ADDRESS_1");
    address c3t_2_address = vm.envAddress("C3T_ADDRESS_2");
    address tco2_1_address = vm.envAddress("TCO2_ADDRESS_1");
    address tco2_2_address = vm.envAddress("TCO2_ADDRESS_2");
    address usdc_address = vm.envAddress("USDC_ADDRESS");

    address[] _addresses = vm.envAddress("RECEIVING_ADDRESSES", ",");
    //address[] _addresses = vm.envAddress("RECEIVING_ADDRESS_TEST",",");
    address[] _tokens = new address[](5);
    uint256[] _amounts = new uint256[](5); // amount to sent per address. The index number corresponds to the token index

    uint send_matic_amount;

    function setUp() public {

        _tokens = [
            c3t_1_address,
            c3t_2_address,
            tco2_1_address,
            tco2_2_address,
            usdc_address
        ];

        _amounts = [
            2 ether,
            2 ether,
            2 ether,
            2 ether,
            0.001 gwei 
        ]; //0.001 gwei is 1 usdc since usdc is 6 digits
        send_matic_amount = 1.5 ether; // 1.5 matic 

    }

    function run() public {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        uint8 i;
        address _to;

        for (i; i < _addresses.length; i++) {

            _to = _addresses[i];
            //emit log_named_address("address current", _to);
            (bool sent, ) = _to.call{value: send_matic_amount}("");
            require(sent, "Failed to send Matic");

        }

        multisendToken();

        vm.stopBroadcast();

    }

    function multisendToken() public payable {

        require(_addresses.length > 0);
        require(_tokens.length == _amounts.length);

        for (uint8 t; t < _tokens.length; t++) {

            for (uint8 i; i < _addresses.length; i++) {

                IERC20(_tokens[t]).transfer(_addresses[i], _amounts[t]);
                //emit log_named_uint("address iteration", i);
                //emit log_named_uint("token iteration", t);

            }

        }
    }

}
