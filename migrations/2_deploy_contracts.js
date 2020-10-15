const MattsuCoin = artifacts.require("MattsuCoin");
const PriceConsumerLib = artifacts.require("PriceConsumerLib");

module.exports = function(deployer, network) {
    deployer.deploy(PriceConsumerLib);
    deployer.link(PriceConsumerLib, MattsuCoin);
    if (network === "develop") {
        deployer.deploy(MattsuCoin, 10000, deployer.networks.develop.from);
    } else if (network === "kovan") {
        deployer.deploy(MattsuCoin, 10000, deployer.networks.kovan.from);
    } else {
        // no-op
    }
};
