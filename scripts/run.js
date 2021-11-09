const main = async () => {
	const signers = await hre.ethers.getSigners();
	const [owner, randomPerson] = signers;
	const contractFactory = await hre.ethers.getContractFactory('MessageWall');
	const messageWallContract = await contractFactory.deploy();
	await messageWallContract.deployed();
	console.log("Contract deployed to:", messageWallContract.address);
	console.log("Contract deployed by:", owner.address);
	let messageCount;
	messageCount = await messageWallContract.getTotalMessageCount();

	let messageTxn = await messageWallContract.incrementMessageCount();
	await messageTxn.wait();
	messageCount = await messageWallContract.getTotalMessageCount();
	messageTxn = await messageWallContract.connect(randomPerson).incrementMessageCount();
	await messageTxn.wait();
	messageCount = await messageWallContract.getTotalMessageCount();
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
