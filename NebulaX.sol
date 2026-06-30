// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NebulaX is ERC20, Ownable {

    uint256 public constant MAX_SUPPLY =
        50_000_000 * 10 ** 18;

    uint256 public constant INITIAL_SUPPLY =
        5_000_000 * 10 ** 18;

    mapping(address => bool) public blacklist;

    event TokensMinted(
        address indexed to,
        uint256 amount
    );

    event TokensBurned(
        address indexed from,
        uint256 amount
    );

    event BlacklistUpdated(
        address indexed user,
        bool status
    );

    constructor()
        ERC20("NebulaX", "NBX")
        Ownable(msg.sender)
    {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function mint(address to, uint256 amount)
        external
        onlyOwner
    {
        require(
            totalSupply() + amount <= MAX_SUPPLY,
            "Max supply exceeded"
        );

        _mint(to, amount);

        emit TokensMinted(to, amount);
    }

    function burn(uint256 amount) external {

        _burn(msg.sender, amount);

        emit TokensBurned(msg.sender, amount);
    }

    function setBlacklist(
        address user,
        bool status
    )
        external
        onlyOwner
    {
        blacklist[user] = status;

        emit BlacklistUpdated(user, status);
    }

    function _update(
        address from,
        address to,
        uint256 amount
    )
        internal
        override
    {
        require(
            !blacklist[from],
            "Sender blacklisted"
        );

        require(
            !blacklist[to],
            "Receiver blacklisted"
        );

        super._update(from, to, amount);
    }

    function circulatingSupply()
        external
        view
        returns (uint256)
    {
        return totalSupply();
    }
}
