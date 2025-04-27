const { ethers } = require('ethers');
const { contract, wallet } = require('../config/ether.js');

// Helper to serialize user data
const serlializeUser = (user) => ({
    id: user.id.toString(),
    name: user.name,
    firstName: user.firstName,
    walletAddress: user.walletAddress
});

const isValidWallet = async (req, res) => {
    try {
        const { address } = req.params;
        // Address format
        if (!ethers.isAddress(address)) {
            return res.status(400).json({ 
                error: 'Invalid address format'
            });
        }
        const isValidated = await contract.isWalletValidated(address);
        res.json({ address, isValidated });
    } catch (error) {
        res.status(500).json({ error: error.massage });
    }
};

const addUser = async (req, res) => {
    try {
          const { name, firstName, walletAddress } = req.body;

          if (!name || !firstName || !walletAddress) {
            return res.status(400).json({ error: 'Invalid input: Missing required fields' });
          }
         
          const tx = await contract.addUser(name, firstName, walletAddress.trim());
          await tx.wait();
          res.json({ message: 'User added successfully', transactionHash: tx.hash });
    } catch (error) {
        console.error('Error adding user:',error);
        res.status(500).json({ error: error.message });
    }
};

const getUserById = async (req, res) => {
    try {
        const { id } = req.params;
        const user = await contract.getUserById(id);
        if (!user || user.id === 'undefined') {
            return res.status(404).json({ error: 'Invalid user id'});
        }

        res.json({ user: serlializeUser(user) });
    } catch (error) {
        console.error('Error fetching user:', error);
        res.status(500).json({ error: error.message });
    }
};

const getUserByAddress = async (req, res) => {
    try {
        const { address } = req.params;
        if (!ethers.isAddress(address) || address === 'undefined') {
            return res.status(400).json({ error: 'Invalid address format' });
        }

        const user = await contract.getUserByAddress(address);
        res.json({ user: serlializeUser(user) });
    } catch (error) {
        console.error('Error fetching user:',error);
        res.status(500).json({ error: error.message });
    }
};

module.exports = {
    isValidWallet,
    addUser,
    getUserById,
    getUserByAddress
};