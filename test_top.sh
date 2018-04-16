rm ./build/contracts/TopProducer.json ./build/contracts/TopPaymentReceiver.json
truffle compile TopPaymentReceiver.sol TopProducer.sol
truffle test test/top_producer.js
