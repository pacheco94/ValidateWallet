const { contract, wallet } = require('../config/ether');

const authenticate = async (req, res, next) => {
    try {
        const owner = await contract.owner();
        if(wallet.address.toLowerCase() !== owner.toLowerCase()) {
            return res.status(403).json({ error: 'Unauthorized. Only owner cant perform this action! '});
        }

        next();
    } catch(error) {
        res.status(500).json({ error: error.message });
    }
}

module.exports = authenticate;