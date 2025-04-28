// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract ValidateWallet is Ownable {
    uint256 public userCount;

    struct User {
        uint256 id;
        string name;
        string firstName;
        address walletAddress;
    }

    //Mapping from address to user
    mapping(address => User) private users;
    //Mapping from user id to address
    mapping(uint256 => address) private userId;
    //Mapping from address validation
    mapping(address => bool) private isValidated;

    //Event to emit when a user is added
    event UserAdded(address indexed userAddress, uint256 id);

    constructor() Ownable(msg.sender) {}

    //Function to authorize a wallet
    function _isAuthorized(address _walletAddress) private view returns (bool) {
        return msg.sender == _walletAddress || msg.sender == owner();
    }

    //modifier to check if user is the owner of address
    modifier onlyAuthorized(address _walletAddress) {
        require(_isAuthorized(_walletAddress), "Not authorized");
        _;
    }

    //Function to validate a wallet;
    function isWalletValidated(
        address _walletAddress
    ) public view returns (bool) {
        return isValidated[_walletAddress];
    }

    //Function to add a user
    function addUser(
        string memory _name,
        string memory _firstName,
        address _walletAddress
    ) public {
        require(!isWalletValidated(_walletAddress), "Wallet already validated");

        User memory newUser = User({
            id: userCount,
            name: _name,
            firstName: _firstName,
            walletAddress: _walletAddress
        });
        //Add user to mapping
        users[_walletAddress] = newUser;
        //Add user id to mapping
        userId[userCount] = _walletAddress;
        isValidated[_walletAddress] = true;
        userCount++;

        //Emit event
        emit UserAdded(_walletAddress, userCount);
    }

    //Function to get user by address authorized user
    function getUserByAddress(
        address _walletAddress
    ) public view onlyAuthorized(_walletAddress) returns (User memory) {
        require(isWalletValidated(_walletAddress), "Wallet not found");
        return users[_walletAddress];
    }

    //Function to get user by id
    function getUserById(
        uint256 _id
    ) public view onlyOwner returns (User memory) {
        require(userId[_id] != address(0), "User not found");
        return users[userId[_id]];
    }
}
