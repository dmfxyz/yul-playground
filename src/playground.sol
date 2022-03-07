// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import 'ds-test/test.sol';
contract YulTestContract is DSTest {

	mapping(uint256 => address) public map;
	uint32 public num = 42;

	function testYulMapping() public {
		map[0] = address(0xb33f);
		map[1] = address(0xf33d);
		map[100] = address(0xf57d);
		address ad;
		uint256 v;

		assembly {
			ad := sload(keccak256(0, 0x40))
			v := and(0x00, map.slot) 

		}
		emit log_address(ad); // logs 0xf57d
		emit log_address(map[0]); // logs 0xb33f
		emit log_uint(v);


	}

}
