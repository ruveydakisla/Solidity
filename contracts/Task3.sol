// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Task3Contract{
    struct Account{
    string name;
    string surname;
    uint256 balance;
    }
    Account  [] public  Admins;

    function getAllAdmins() public view returns(Account[] memory) {
    Account[] memory _admins;
    for(uint i=0;i<_admins.length;i++){
        _admins[i] = Admins[i];
    }

    return _admins;
}
}