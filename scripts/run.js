const main = async ()=> {
    const [owner, randomSigner] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther("0.1"),
    });
    await waveContract.deployed();

    console.log("Contract deployed to: ", waveContract.address);
    console.log("Contract deployed by: ", owner.address);

    //Get Contract Balance
    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log("Contract Balance: ", hre.ethers.utils.formatEther(contractBalance))

    let waveTxn = await waveContract.wave("bla bla")
    await waveTxn.wait();

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log("Contract Balance: ", hre.ethers.utils.formatEther(contractBalance))

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