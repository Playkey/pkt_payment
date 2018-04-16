pragma solidity ^0.4.19;

import "./installed/token/ERC20.sol";

contract PaymentReceiver
{
  address private constant taxman = 0x718db7Fa19C11cc9194446CCBDF8fCDA136f7DEF;
  address private constant store = 0x3bE5424b83fB410703D357907f1E9CDB0f7279FD;
  address private constant pkt = 0x2604FA406Be957E542BEb89E6754fCdE6815e83f;

  modifier onlyTaxman { require(msg.sender == taxman); _; }

  function withdrawTokens(uint256 value) external onlyTaxman
  {
    ERC20 token = ERC20(pkt);
    token.transfer(store, value);
  }
}
