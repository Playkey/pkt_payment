pragma solidity ^0.4.19;

import "./CheapPaymentReceiver.sol";

contract CheapProducer
{
  address public owner;
  address public deployer;

  event OwnerChanged(address indexed previousOwner, address indexed newOwner);
  event DeployerChanged(address indexed previousDeployer, address indexed newDeployer);
  event PaymentReceiverDeployed(address indexed receiver);

  modifier onlyOwner { require(msg.sender == owner); _; }
  modifier onlyDeployer { require(msg.sender == deployer); _; }

  function CheapProducer(address _owner, address _deployer) public
  {
    owner = _owner;
    deployer = _deployer;
  }

  function deployPaymentReceiver(uint8 N) external onlyDeployer
  {
    for(uint8 i = 0; i < N; ++i)
    {
      address receiver = new CheapPaymentReceiver();
      PaymentReceiverDeployed(receiver);
    }
  }

  function changeOwner(address newOwner) external onlyOwner
  {
    require(newOwner != address(0));
    OwnerChanged(owner, newOwner);
    owner = newOwner;
  }

  function changeDeployer(address newDeployer) external onlyOwner
  {
    require(newDeployer != address(0));
    DeployerChanged(deployer, newDeployer);
    deployer = newDeployer;
  }
}
