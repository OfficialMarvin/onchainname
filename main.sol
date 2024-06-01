// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NameList {
    address public immutable owner;
    string[] public names;
    mapping(uint256 => uint256) public nameValues; // Mapping to store value sent with each name

    event NameAdded(uint256 indexed id, string name, uint256 value);
    event NameRemoved(uint256 indexed id, string name);

    constructor() {
        owner = msg.sender;
    }

    /**
     * @notice Append a name to the list, optionally sending ETH to the contract.
     * @param _name The name to add to the list.
     */
    function appendName(string memory _name) public payable {
        require(msg.sender == owner, "Only the contract owner can add names");
        uint256 id = names.length;
        names.push(_name);
        nameValues[id] = msg.value;
        emit NameAdded(id, _name, msg.value);
    }

    /**
     * @notice Remove a name from the list. Internal function.
     * @param _id The index of the name to remove from the list.
     */
    function _removeName(uint256 _id) internal {
        require(_id < names.length, "Invalid ID");
        string memory name = names[_id];
        names[_id] = names[names.length - 1];
        names.pop();
        delete nameValues[_id];
        emit NameRemoved(_id, name);
    }

    /**
     * @notice Safely remove a name from the list. Only callable by the contract owner.
     * @param _id The index of the name to remove from the list.
     */
    function safeRemoveName(uint256 _id) public {
        require(msg.sender == owner, "Only the contract owner can remove names");
        _removeName(_id);
    }

    /**
     * @notice Withdraw and Donate to Gaza through The Giving Block.
     */
    function withdraw() public {
        require(msg.sender == owner, "Nice try!");
        payable(owner).transfer(address(this).balance);
    }
}
