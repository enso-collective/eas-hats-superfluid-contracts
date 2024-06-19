import hre from "hardhat";

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  const flowSenderAddress = "0x98eB0184BC4fbe1D8c158f421ea75EC2b150559A";
  const FlowSender = await hre.ethers.getContractFactory("FlowSender");
  const flowSender = await FlowSender.connect(deployer).attach(
    flowSenderAddress
  );

  //@ts-ignore
  const res = await flowSender.gainDaiX();
  console.log({ res });

  console.log("gainDaiX function called successfully");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
