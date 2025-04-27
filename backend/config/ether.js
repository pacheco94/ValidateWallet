const ethers = require('ethers');
require('dotenv').config();
const contractABI = require('../abi/abi.json').abi;


//Provider config
const provider = new ethers.JsonRpcProvider(process.env.Anvil_URL);
const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
const contractAddress = process.env.CONTRACT_ADDRESS;
const contract = new ethers.Contract(contractAddress, contractABI, wallet);

module.exports = {provider, contract, ethers, wallet};