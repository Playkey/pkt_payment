const PKT = artifacts.require("./TestToken.sol");

module.exports = (deployer, network) => {
    deployer.deploy(PKT);
};
