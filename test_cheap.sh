rm ./build/contracts/CheapProducer.json ./build/contracts/CheapPaymentReceiver.json
truffle compile CheapPaymentReceiver.sol CheapProducer.sol
truffle test test/cheap_producer.js
