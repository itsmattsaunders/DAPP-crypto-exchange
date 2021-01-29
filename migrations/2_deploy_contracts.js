const Token = artifacts.require("Token");

const EthSwap = artifacts.require("EthSwap");


module.exports = async (deployer) => {

  //Deploy Token
  await deployer.deploy(Token)
  const token = await Token.deployed()

  //Deplot EthSwap
  await deployer.deploy(EthSwap);
  const ethSwap = await EthSwap.deployed()

  //Transfer all tokens to EthSwap
  await token.transfer(ethSwap.address, '1000000000000000000000000')
};