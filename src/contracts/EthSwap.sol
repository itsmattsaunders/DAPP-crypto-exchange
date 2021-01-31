pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
    string public name = "EthSwap Instant Exchange";
    Token public token;
    uint256 public rate = 100;

    event tokenPurchased(
        address account,
        address token,
        uint256 amount,
        uint256 rate
    );

    event tokenSold(
        address account,
        address token,
        uint256 amount,
        uint256 rate
    );

    constructor(Token _token) public {
        token = _token;
    }

    function buyTokens() public payable {
        //Redemption rate = # of tokens they recieve for 1 ETH
        //ETH * redeption rate
        uint256 tokenAmount = msg.value * rate;

        // Require that EthSwap has enough tokens
        require(token.balanceOf(address(this)) >= tokenAmount);

        // Transfer tokens to the user
        token.transfer(msg.sender, tokenAmount);

        //Emit an event
        emit tokenPurchased(msg.sender, address(token), tokenAmount, rate);
    }

    function sellTokens(uint256 _amount) public{
        //User can't sell more tokens then they have
        require(token.balanceOf(msg.sender) >= _amount);

        //Calculate redemable amount
        uint256 etherAmount = _amount / rate;

        //require that ethSwap has enough Ether
        require(address(this).balance >= etherAmount);

        //Perform sale
        token.transferFrom(msg.sender, address(this), _amount);
        msg.sender.transfer(etherAmount);

        //Emit an event
        emit tokenSold(msg.sender, address(token), _amount, rate);
    }
}
