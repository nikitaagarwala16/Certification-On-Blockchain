var Contract = artifacts.require("./impCertification.sol");
var Factory = artifacts.require("./CertificationFactory.sol");
module.exports = function(deployer) {
  deployer.deploy(Factory);
  //deployer.deploy(Contract)
};
