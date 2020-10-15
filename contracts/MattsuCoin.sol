pragma solidity ^0.6.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/presets/ERC20PresetMinterPauser.sol";
import "./PriceConsumerLib.sol";

contract MattsuCoin is ERC20, AccessControl {

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    constructor(uint256 initialSupply, address admin) public ERC20("Mattsu", "MAT") {
        _setupDecimals(3);
        _mint(msg.sender, initialSupply);
        _setupRole(ADMIN_ROLE, admin);
    }

    function mint(address to, uint256 amount) public {
        require(hasRole(ADMIN_ROLE, msg.sender), "You are not admin");
        _mint(to, amount);
    }

    function burn(address to, uint256 amount) public {
        require(hasRole(ADMIN_ROLE, msg.sender), "You are not admin");
        _burn(to, amount);
    }

    function getEthUsd() public view returns (int) {
        return PriceConsumerLib.getEthUsd();
    }
}