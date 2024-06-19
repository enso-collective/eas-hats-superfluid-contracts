// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import { ISuperfluid, ISuperToken,FlowOperatorDefinitions,
    IConstantFlowAgreementV1 } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";
// import {
//     ISuperfluid,
//     ISuperToken,
    
// } from "../interfaces/superfluid/ISuperfluid.sol";

interface ICFAv1Forwarder {
    function setFlowrate(ISuperToken token, address receiver, int96 flowrate) external returns (bool);

    function setFlowrateFrom(
        ISuperToken token,
        address sender,
        address receiver,
        int96 flowrate
    ) external returns (bool);

    function getFlowrate(ISuperToken token, address sender, address receiver) external view returns (int96 flowrate);

    function getFlowInfo(ISuperToken token, address sender, address receiver)
        external
        view
        returns (
            uint256 lastUpdated,
            int96 flowrate,
            uint256 deposit,
            uint256 owedDeposit
        );

    function getBufferAmountByFlowrate(ISuperToken token, int96 flowrate) external view returns (uint256 bufferAmount);

    function getAccountFlowrate(ISuperToken token, address account) external view returns (int96 flowrate);

    function getAccountFlowInfo(ISuperToken token, address account)
        external
        view
        returns (
            uint256 lastUpdated,
            int96 flowrate,
            uint256 deposit,
            uint256 owedDeposit
        );

    function createFlow(
        ISuperToken token,
        address sender,
        address receiver,
        int96 flowrate,
        bytes memory userData
    ) external returns (bool);

    function updateFlow(
        ISuperToken token,
        address sender,
        address receiver,
        int96 flowrate,
        bytes memory userData
    ) external returns (bool);

    function deleteFlow(
        ISuperToken token,
        address sender,
        address receiver,
        bytes memory userData
    ) external returns (bool);

    function grantPermissions(ISuperToken token, address flowOperator) external returns (bool);

    function revokePermissions(ISuperToken token, address flowOperator) external returns (bool);

    function updateFlowOperatorPermissions(
        ISuperToken token,
        address flowOperator,
        uint8 permissions,
        int96 flowrateAllowance
    ) external returns (bool);

    function getFlowOperatorPermissions(
        ISuperToken token,
        address sender,
        address flowOperator
    ) external view returns (uint8 permissions, int96 flowrateAllowance);
}