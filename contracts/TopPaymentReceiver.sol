pragma solidity ^0.4.19;

import "./installed/token/ERC20.sol";

contract TopPaymentReceiver
{
  address public taxman;
  address public store;

  modifier onlyTaxman { require(msg.sender == taxman); _; }

  function TopPaymentReceiver(address _taxman, address _store) public
  {
    taxman = _taxman;
    store = _store;
  }

  function withdrawTokens() external onlyTaxman
  {
    ERC20 token = ERC20(0xD5a50da3FB4E24262e3D583f7700031d5516418F);
    token.transfer(store, token.balanceOf(this));
  }
}
