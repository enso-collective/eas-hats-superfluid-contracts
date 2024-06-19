//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.19;

import { ISuperfluid, ISuperToken } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";

import { SuperTokenV1Library } from "@superfluid-finance/ethereum-contracts/contracts/apps/SuperTokenV1Library.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {ICFAv1Forwarder} from "./Cfa.sol";


interface IFakeDAI is IERC20 {

    function mint(address account, uint256 amount) external;

}

contract FlowSender {

    using SuperTokenV1Library for ISuperToken;
    address cfaAddress = 0xcfA132E353cB4E398080B9700609bb008eceB125;
    mapping (address => bool) public accountList;

    ISuperToken public daix;

    constructor(ISuperToken _daix) {

        daix = _daix;
        accountList[0x344efE6b4842A74D711232741fa27F5Ee688Ce0b] = true;
        accountList[0x0cb27e883E207905AD2A94F9B6eF0C7A99223C37] = true;
        accountList[0xC06C7C6ec618DE992d597D8e347669EA44eDe2bc] = true;
        accountList[0xd350F597ceF325ecCBbe2f26B9cBf16D50c220Bd] = true;
        
    }


    modifier onlyAllowedAccounts() {
        require(accountList[msg.sender], "Only allowed accounts can call this function.");
        _;
    }
    /// @dev Mints 10,000 fDAI to this contract and wraps it all into fDAIx
    function gainDaiX() external onlyAllowedAccounts {

        IFakeDAI fdai = IFakeDAI( daix.getUnderlyingToken() );
        
        fdai.approve(address(daix), 20000e18);

        
        daix.upgrade(10000e18);

    }

    

    function grantPermissions(ISuperToken token, address flowOperator) public onlyAllowedAccounts returns (bool){
         ICFAv1Forwarder cfa = ICFAv1Forwarder(cfaAddress);
         return  cfa.grantPermissions(token, flowOperator);
    }

}