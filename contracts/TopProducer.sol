pragma solidity ^0.4.19;

import "./TopPaymentReceiver.sol";

contract TopProducer
{
  address public owner;
  address public deployer;
  address public taxman;
  address public store;

  event OwnerChanged(address indexed previousOwner, address indexed newOwner);
  event DeployerChanged(address indexed previousDeployer, address indexed newDeployer);
  event TaxmanChanged(address indexed previousTaxman, address indexed newTaxman);
  event StoreChanged(address indexed previousStore, address indexed newStore);
  event PaymentReceiverDeployed(address indexed receiver);

  modifier onlyOwner { require(msg.sender == owner); _; }
  modifier onlyDeployer { require(msg.sender == deployer); _; }

  function TopProducer(address _owner, address _deployer, address _taxman, address _store) public
  {
    owner = _owner;
    deployer = _deployer;
    taxman = _taxman;
    store = _store;
  }

  function deployPaymentReceiver(uint8 N) external onlyDeployer
  {
    for(uint8 i = 0; i < N; ++i)
    {
      address receiver = new TopPaymentReceiver(taxman, store);
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

  function changeTaxman(address newTaxman) external onlyOwner
  {
    require(newTaxman != address(0));
    TaxmanChanged(taxman, newTaxman);
    taxman = newTaxman;
  }

  function changeStore(address newStore) external onlyOwner
  {
    require(newStore != address(0));
    StoreChanged(store, newStore);
    store = newStore;
  }
}
