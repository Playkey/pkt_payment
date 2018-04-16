const Producer = artifacts.require("./CheapProducer.sol");
const PaymentReceiver = artifacts.require("./CheapPaymentReceiver.sol");
const PKT = artifacts.require("./TestToken.sol");

const [owner, deployer, taxman, store, user] = web3.eth.accounts

contract("Producer", async () => {
	let pkt = await web3.eth.contract(PKT.abi).at('0xD5a50da3FB4E24262e3D583f7700031d5516418F');
	console.log(await pkt.name());
	await pkt.mint(user, web3.toWei('1000', 'ether'), {from:owner});

	const printBalance = async (name, address) => {
		console.log(name, "balance =", (await pkt.balanceOf(address)).div('1e18').toFixed(), "PKT");
	}
	await printBalance("User", user);

	let producer = await Producer.new(owner, deployer);
	console.log("Producer address:", producer.address);
	let receipt = web3.eth.getTransactionReceipt(producer.transactionHash);
	console.log("Deploying Producer gas used:", receipt.gasUsed);

	let rc_addr;
	let ev = await producer.PaymentReceiverDeployed('latest', async (error, result) => {
			if (!error) {
				rc_addr = result.args.receiver;
				let receiver = await web3.eth.contract(PaymentReceiver.abi).at(rc_addr);
				console.log("Receiver address:", receiver.address);
				await pkt.transfer(receiver.address, web3.toWei('10', 'ether'), {from:user});
				await printBalance("Receiver", receiver.address);

				await printBalance("Store", store);
				let tx = await receiver.withdrawTokens(web3.toWei('10', 'ether'), {from:taxman});
				receipt = web3.eth.getTransactionReceipt(tx);
				console.log("withdrawTokens gas used:", receipt.gasUsed);
				await printBalance("Store", store);
			} else
				console.error(error);
			ev.stopWatching();
	 });

	let tx = await producer.deployPaymentReceiver(1, {from:deployer});
	console.log("Deploying PaymentReceiver gas used:", tx.receipt.gasUsed);
})
