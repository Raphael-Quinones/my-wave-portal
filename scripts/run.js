const main = async ()=> {
    const [owner, randomSigner] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract deployed to: ", waveContract.address);
    console.log("Contract deployed by: ", owner.address);

    await waveContract.getTotalWaves();
    
    const firstWaveTxn = await waveContract.wave();
    await firstWaveTxn.wait();

    const secondWaveTxn = await waveContract.connect(randomSigner).wave();
    await secondWaveTxn.wait();

    await waveContract.getTotalWaves();
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);//Exit Node process without error
    } catch (error){
        console.log(error);
        process.exit(1);
    }
};

runMain();