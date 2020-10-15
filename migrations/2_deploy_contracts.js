const MattsuCoin = artifacts.require("MattsuCoin");
const PriceConsumerLib = artifacts.require("PriceConsumerLib");

module.exports = function(deployer, networks) {
    deployer.deploy(PriceConsumerLib);
    deployer.link(PriceConsumerLib, MattsuCoin);
    deployer.deploy(MattsuCoin, 10000, deployer.networks.develop.from);
};
