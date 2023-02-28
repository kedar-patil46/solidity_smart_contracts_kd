//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./simple_storage.sol";

contract Storage_Factory is Simple_Storage
{
    Simple_Storage[] public simple_store;
    function createSimpleStorage() public
    {
        Simple_Storage s_s = new Simple_Storage();
        simple_store.push(s_s);
    }

    

    function sfStore(uint256 _simple_storeIndex, uint256  simp_store_favnum) public
    {
        Simple_Storage s_s = Simple_Storage(address(simple_store[_simple_storeIndex]));
        s_s.store(simp_store_favnum);
    }

    function sfRetrieve(uint256 _simple_storeIndex) public view returns(uint256)
    {
        Simple_Storage s_s = Simple_Storage(address(simple_store[_simple_storeIndex]));
        return s_s.retrieve();
    }
}
