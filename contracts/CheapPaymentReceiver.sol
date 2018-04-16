pragma solidity ^0.4.19;

import "./installed/token/ERC20.sol";

contract CheapPaymentReceiver
{
  address public constant taxman = 0x718db7Fa19C11cc9194446CCBDF8fCDA136f7DEF;
  address public constant store = 0x3bE5424b83fB410703D357907f1E9CDB0f7279FD;

  modifier onlyTaxman { require(msg.sender == taxman); _; }

  function withdrawTokens(uint256 value) external onlyTaxman
  {
    ERC20 token = ERC20(0xD5a50da3FB4E24262e3D583f7700031d5516418F);
    token.transfer(store, value);
  }
}
