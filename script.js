const Web3 = require('web3');

// Replace with your contract address and ABI
const contractAddress = '0x...';
const contractABI = [...]; // Your contract ABI

const web3 = new Web3(new Web3.providers.HttpProvider('https://mainnet.infura.io/v3/YOUR_PROJECT_ID'));

const contract = new web3.eth.Contract(contractABI, contractAddress);

const nameListElement = document.getElementById('name-list');

contract.methods.names().call()
    .then(names => {
        names.forEach((name, index) => {
            const nameElement = document.createElement('div');
            nameElement.className = 'name-item';
            nameElement.textContent = `${index + 1}. ${name}`;
            nameListElement.appendChild(nameElement);
        });
    })
    .catch(error => console.error(error));
