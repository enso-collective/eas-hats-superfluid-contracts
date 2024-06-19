import hre from "hardhat";

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  const flowSenderAddress = "0x98eB0184BC4fbe1D8c158f421ea75EC2b150559A";
  const FlowSender = await hre.ethers.getContractFactory("FlowSender");
  const flowSender = await FlowSender.connect(deployer).attach(
    flowSenderAddress
  );

  const recipientAddress = "0xBe0D69A1A3311AD17B19C308839fE8870CDe2232";
  const fDAIxAddress = "0x344efE6b4842A74D711232741fa27F5Ee688Ce0b";
  //@ts-ignore
  const res = await flowSender.grantPermissions(fDAIxAddress, recipientAddress);
  console.log({ res });

  console.log(`Successfully granted permission to ${recipientAddress}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
