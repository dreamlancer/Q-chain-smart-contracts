pragma solidity ^0.4.23;


import "../token/ERC20/MintableToken.sol";


/**
 * @title SimpleMintableToken for QChain Visual Smart Contract Designer
 */
contract SimpleToken is MintableToken {

  string public name;
  string public symbol;
  uint8 public constant decimals = 18;

  /**
   * @dev Constructor makes msg.sender as admin of token contract.
   */
  constructor(
    string _name,
    string _symbol
  ) public {
    name = _name;
    symbol = _symbol;
  }

}