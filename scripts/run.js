const main = async ()=> {
    const [owner, randomSigner] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();

    console.log("Contract deployed to: ", waveContract.address);
    console.log("Contract deployed by: ", owner.address);

    let waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());
    
    const firstWaveTxn = await waveContract.wave("Hello there!");
    await firstWaveTxn.wait();

    const secondWaveTxn = await waveContract.connect(randomSigner).wave("the second hello!");
    await secondWaveTxn.wait();

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves)

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