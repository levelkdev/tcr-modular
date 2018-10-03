pragma solidity ^0.4.24;

import './OwnedItemRegistry.sol';

// provides a mapping of unlock times for items. Only allows
// item removal when the unlock time has been exceeded.
contract LockableItemRegistry is OwnedItemRegistry {
  mapping(bytes32 => uint) public unlockTimes;

  function remove(bytes32 id) public {
    require(!isLocked(id));
    delete unlockTimes[id];
    super.remove(id);
  }

  function isLocked(bytes32 id) public view returns (bool) {
    return unlockTimes[id] > now;
  }
}