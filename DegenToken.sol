// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    struct eggObj {
        string name;
        uint256 cost;
    }

    eggObj[] private storeEgg;

    constructor() ERC20("Degen", "DGN") {
        _mint(msg.sender, 0);

        storeEgg.push(eggObj("Golden Egg", 172));
        storeEgg.push(eggObj("Easter Egg", 95));
        storeEgg.push(eggObj("Faberge", 358));
    }

    function mint(address to, uint256 amount) public onlyOwner {
        require(amount > 0, "You must mint ATLEAST 1 token!");
        _mint(to, amount);
    }

    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function burn(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount, "Insufficient Balance!");
        require(amount > 0, "You must burn ATLEAST 1 token!");
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        require(msg.sender != to, "You cannot transfer tokens to your own account!");
        require(balanceOf(msg.sender) >= amount, "Insuffecient Balance!");
        return super.transfer(to, amount);
    }

    function getEgg(uint256 eggId) external {
        require(eggId < storeEgg.length, "There's no egg that matches with the entered ID");
        eggObj storage egg = storeEgg[eggId];
        require(balanceOf(msg.sender) >= egg.cost, "Insufficient Balance!");
        _burn(msg.sender, egg.cost);
    }

    function checkShop() external view returns (eggObj[] memory) {
        return storeEgg;
    }
}
