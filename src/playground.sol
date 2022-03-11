// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.11;

import 'ds-test/test.sol';

contract YulTestContract is DSTest {

	// This state vars just push map into slot 2 for fun
	uint256 public num = 42;
	// map 
	mapping(uint256 => address) public map;
	function testYulMapping() public {
		map[0] = address(0xb33f);
		map[10] = address(0xf33d);
		map[7] = address(0xdead);

		address addrAt0;
		address addrAt10;
		address addrAt7;
		assembly {
		// store the maps slot in scratch space @2nd word pos. We'll reuse this for each lookup
			mstore(0x20, map.slot)
		// store the 0 key in the first word of scratch space
			mstore(0x0, 0x0)
		// the value at key 0 is stored at sha3(0 . map.slot)
			addrAt0 := sload(keccak256(0, 0x40))
		// the value at key 10 is stored at sha3(10 . map.slot)
			mstore(0x0, 0xa)
			addrAt10 := sload(keccak256(0, 0x40))
		// the value at key 7 is stored at sha3(7 . map.slot)
			mstore(0x0, 0x7)
			addrAt7 := sload(keccak256(0, 0x40))
		}
		emit log_address(addrAt7);
		emit log_address(addrAt10);
		emit log_address(addrAt0);
		/*
		Logs:
  			0x000000000000000000000000000000000000dead
  			0x000000000000000000000000000000000000f33d
  			0x000000000000000000000000000000000000b33f
		*/
	}

}
