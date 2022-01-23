// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Ownable.sol";

contract Library is Ownable {
    address libraryAddress = address(this);

    event NewBook(uint256 id, string name, uint8 copies, address borrower);

    struct Book {
        uint256 id;
        string name;
        uint8 copies;
        address borrower;
    }

    Book[] public books;

    function _generateRandomId(string memory _name)
        private
        pure
        returns (uint256)
    {
        uint256 rand = uint256(keccak256(abi.encodePacked(_name)));
        return rand;
    }

    function addBooks(string memory _name, uint8 _copies) external onlyOwner {
        uint256 bookId = _generateRandomId(_name);
        books.push(Book(bookId, _name, _copies, libraryAddress));
        emit NewBook(bookId, _name, _copies, libraryAddress);
    }
}
