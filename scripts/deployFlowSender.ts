import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  const fDAIxAddress = "0x344efE6b4842A74D711232741fa27F5Ee688Ce0b";

  const FlowSender = await ethers.getContractFactory("FlowSender");
  const flowSender = await FlowSender.connect(deployer).deploy(fDAIxAddress);

  await flowSender.waitForDeployment();

  const flowSenderAddress = await flowSender.getAddress();
  console.log("FlowSender deployed to:", flowSenderAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
