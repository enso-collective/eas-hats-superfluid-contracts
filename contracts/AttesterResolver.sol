// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import { Address } from "@openzeppelin/contracts/utils/Address.sol";

import { SchemaResolver } from "@ethereum-attestation-service/eas-contracts/contracts/resolver/SchemaResolver.sol";

import { IEAS, Attestation } from "@ethereum-attestation-service/eas-contracts/contracts/IEAS.sol";


import {ICFAv1Forwarder} from "./Cfa.sol";

import {  ISuperToken } from "@superfluid-finance/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol";


interface IHats {
    function isWearerOfHat(address _user, uint256 _hatId) external view returns (bool isWearer);
    function mintHat(uint256 _hatId, address _wearer) external returns (bool success);
    function setHatWearerStatus(uint256 _hatId, address _wearer, bool _eligible, bool _standing)
        external
        returns (bool updated);
}


contract AttesterResolver is SchemaResolver {
    
    address cfaAddress = 0xcfA132E353cB4E398080B9700609bb008eceB125;
    address hatsContractAddress = 0x3bc1A0Ad72417f2d411118085256fC53CBdDd137;
    uint256 hatId = 0x0000002b00010000000000000000000000000000000000000000000000000000;
    address streamSenderAddress = 0x98eB0184BC4fbe1D8c158f421ea75EC2b150559A;
    address bentoXAddress = 0x344efE6b4842A74D711232741fa27F5Ee688Ce0b;
    IHats hats = IHats(hatsContractAddress);
    ICFAv1Forwarder cfa = ICFAv1Forwarder(cfaAddress);
    ISuperToken public daix;

    constructor(IEAS eas,ISuperToken _daix) SchemaResolver(eas) {
        daix = _daix;
    }

    function onAttest(Attestation calldata attestation, uint256 /*value*/) internal override returns (bool) {
        try cfa.createFlow(daix,streamSenderAddress, attestation.recipient, 115740740740741, "0x"){
        } catch (bytes memory) { 
        }
        bool hasHat = hats.isWearerOfHat(attestation.recipient,hatId);
        if(hasHat){
            return true;
        }
        return hats.mintHat(hatId, attestation.recipient);
    }

    function onRevoke(Attestation calldata attestation, uint256 /*value*/) internal  override returns (bool) {
        try cfa.deleteFlow(daix,streamSenderAddress, attestation.recipient, "0x"){
        } catch (bytes memory) {
        
        }
        try hats.setHatWearerStatus(hatId,attestation.recipient,false,true){
        } catch (bytes memory) {
        }
        
        return true;
    }

}
