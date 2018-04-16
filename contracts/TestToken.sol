pragma solidity ^0.4.15;

import "./installed/token/StandardToken.sol";

contract TestToken is StandardToken {

  // Constants
  // =========

  string public constant name = "Test Token";
  string public constant symbol = "TKT";
  uint8 public constant decimals = 18;

  // Priveleged functions
  // ====================

  // Mint few tokens and transfer them to some address.
  function mint(address _holder, uint256 _value) {
    require(_holder != address(0));
    require(_value != 0);

    balances[_holder] += _value;
    totalSupply += _value;
    Transfer(0x0, _holder, _value);
  }

}
