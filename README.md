# ValidateWallet

A comprehensive wallet validation system built with Solidity, Foundry, and Node.js. This project provides a secure way to validate and manage wallet addresses with associated user information.

## Project Structure

- `validate-wallet/`: Contains the Solidity smart contract for wallet validation
- `backend/`: Node.js API for interacting with the smart contract
- `scripts/`: Deployment and interaction scripts
- `test/`: Foundry test files

## Features

- Wallet address validation
- User management with name and wallet association
- Secure authorization system
- RESTful API for contract interaction
- Comprehensive test suite

## Prerequisites

- Node.js (v14 or higher)
- Foundry
- Git

## Installation

1. Clone the repository:
```bash
git clone https://github.com/pacheco94/ValidateWallet.git
cd ValidateWallet
```

2. Install Foundry dependencies:
```bash
cd validate-wallet
forge install
```

3. Install backend dependencies:
```bash
cd ../backend
npm install
```

4. Configure environment variables:
   - Create a `.env` file in the backend directory
   - Add necessary variables (see `.env.example`)

## Usage

### Smart Contract

1. Deploy the contract:
```bash
cd validate-wallet
forge script scripts/deploy.js
```

2. Run tests:
```bash
forge test
```

### Backend API

1. Start the server:
```bash
cd backend
npm start
```

2. API endpoints will be available at `http://localhost:3000`

## Testing

- Smart Contract Tests: `forge test`
- Backend Tests: `npm test` (in backend directory)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
