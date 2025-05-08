// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NebulaX is ERC20, Ownable {
    // События для эмиссии и сжигания токенов
    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);

    // Конструктор: передаём initialOwner в Ownable
    constructor(address initialOwner)
        ERC20("NebulaX", "NBX")
        Ownable(initialOwner)
    {
        // Выполняем начальную эмиссию токенов на адрес initialOwner
        _mint(initialOwner, 500000000000 * 10 ** decimals());
    }

    // Функция для эмиссии токенов, доступная только владельцу контракта
    function mint(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "ERC20: mint to the zero address");
        require(amount > 0, "ERC20: amount must be greater than zero");

        _mint(to, amount);
        emit Mint(to, amount);
    }

    // Функция для сжигания токенов, доступная только владельцу контракта
    function burn(uint256 amount) external onlyOwner {
        require(amount > 0, "ERC20: amount must be greater than zero");

        _burn(msg.sender, amount);
        emit Burn(msg.sender, amount);
    }
}
