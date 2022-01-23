// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Library.sol";

contract Users is Library {
    event BookBorrowed(uint256 id, address borrower);
    event BookReturned(uint256 id);

    struct BorrowHistory {
        uint256 id;
        address[] userAddress;
    }

    mapping(address => BorrowHistory[]) borrowHistory;

    function seeAvailableBooks() public view returns (string[] memory) {
        string[] memory result = new string[](books.length);
        for (uint256 i = 0; i < books.length; i++) {
            result[i] = books[i].name;
        }
        return result;
    }

    function borrowBook(uint256 _bookId) public {
        require(_bookId >= 0, "Book id invalid");
        require(
            books[_bookId].borrower == libraryAddress,
            "This book isn't in library"
        );
        require(books[_bookId].copies > 0, "This book isn't in stock");
        require(
            books[_bookId].borrower != msg.sender,
            "This book is already borrowed by you"
        );

        books[_bookId].borrower = msg.sender;

        emit BookBorrowed(_bookId, msg.sender);
    }

    function returnBook(uint256 _bookId) public {
        require(_bookId >= 0, "Book id invalid");
        require(
            books[_bookId].borrower == msg.sender,
            "This book isn't borrowed by you"
        );

        books[_bookId].borrower = libraryAddress;

        emit BookReturned(_bookId);
    }
}
