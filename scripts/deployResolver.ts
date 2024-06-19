import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  const fDAIxAddress = "0x344efE6b4842A74D711232741fa27F5Ee688Ce0b";
  const easAddress = "0x4200000000000000000000000000000000000021";

  const Resolver = await ethers.getContractFactory("AttesterResolver");
  const resolver = await Resolver.connect(deployer).deploy(
    easAddress,
    fDAIxAddress
  );
  await resolver.waitForDeployment();

  const resolverAddress = await resolver.getAddress();
  console.log("Resolver deployed to:", resolverAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
