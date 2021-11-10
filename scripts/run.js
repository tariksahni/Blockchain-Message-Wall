const main = async () => {
	const signers = await hre.ethers.getSigners();
	const [owner, randomPerson] = signers;
	const contractFactory = await hre.ethers.getContractFactory('MessageWall');
	const messageWallContract = await contractFactory.deploy({
		value: hre.ethers.utils.parseEther('0.1'),
	});
	await messageWallContract.deployed();
	console.log("Contract deployed to:", messageWallContract.address, owner.address);


	let contractBalance = await hre.ethers.provider.getBalance(
		messageWallContract.address
	);
	console.log("contract balance",  hre.ethers.utils.formatEther(contractBalance));

	let messageTxn = await messageWallContract.setMessage('Test Message');
	await messageTxn.wait();
	contractBalance = await hre.ethers.provider.getBalance(messageWallContract.address);
	console.log(
		'Contract balance after transaction:',
		hre.ethers.utils.formatEther(contractBalance)
	);
	const messages = await messageWallContract.getMessages();
};

const runMain = async () => {
	try {
		await main();
		process.exit(0);
	} catch (error) {
		console.log(error);
		process.exit(1);
	}
};

runMain();
