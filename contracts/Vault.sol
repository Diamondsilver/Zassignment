pragma solidity ^0.7.6;

interface IFlashloanReceiver {
    function execute() external payable;
    
}

contract Vault {

    mapping(address => uint256) public balances;

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }

    function balanceOf(address _who) public view returns (uint256 balance){
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount){
            (bool result, bytes memory data) = msg.sender.call{value: _amount}("");
            if (result){
                _amount;
            }
            balances[msg.sender] -= _amount;
        }

    }


    function flashloan(uint256 amount) external {
        uint256 balancesBefore = address(this).balance;
        require(balancesBefore >= amount, "Not enough eth in balance");
        IFlashloanReceiver(msg.sender).execute{value: amount}();
        require(address(this).balance >= balancesBefore, "Flashloan not payed back");
    }

    fallback() external payable {}
    receive() external payable {}
}
