// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

// Use the repo SwapVM abstract and VM libs:
import "../SwapVM.sol";
import "../libs/VM.sol";

/// Concrete test implementation of SwapVM with a single opcode:
/// OPCODE 0: set ctx.swap.amountOut = abi.decode(args, uint256)
contract ConcreteSwapVM is SwapVM {
    constructor(address aqua) SwapVM(aqua, "ConcreteSwapVM", "1") {}

    // Opcode implementation: set amountOut immediate
    function _op_set_amount_out(Context memory ctx, bytes calldata args) internal {
        uint256 amount = abi.decode(args, (uint256));
        ctx.swap.amountOut = amount;
    }

    // Return opcode array where index 0 -> _op_set_amount_out
    function _instructions() internal pure override returns (function(Context memory, bytes calldata) internal[] memory) {
        function(Context memory, bytes calldata) internal[] memory ops = new function(Context memory, bytes calldata) internal[](1);
        ops[0] = _op_set_amount_out;
        return ops;
    }
}