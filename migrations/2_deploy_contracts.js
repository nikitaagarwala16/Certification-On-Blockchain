var deploy_cer = artifacts.require("./SimpleStorage.sol");

module.exports = function(deployer) {
  deployer.deploy(deploy_cer);
};
