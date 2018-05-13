pragma solidity ^0.4.23;


import "../token/ERC20/StandardToken.sol";


/**
 * @title SimpleToken for QChain Visual Smart Contract Designer
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `StandardToken` functions.
 */
contract SimpleToken is StandardToken {

  string public name;
  string public symbol;
  uint8 public constant decimals = 18;

  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  constructor(
    string _name,
    string _symbol,
    uint256 _initialSupply
  ) public {
    name = _name;
    symbol = _symbol;

    totalSupply_ = _initialSupply * (10 ** uint256(decimals));
    balances[msg.sender] = totalSupply_;

    emit Transfer(0x0, msg.sender, totalSupply_);
  }

}
