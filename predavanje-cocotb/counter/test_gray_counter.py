from pathlib import Path
import logging
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, Timer, FallingEdge, RisingEdge
from cocotb_tools.runner import get_runner

LIMIT = 3

async def wait_for_tick(dut):
    # The prescaler counts 0, 1, 2, 3, then ticks on the next edge.
    await ClockCycles(dut.clk, LIMIT + 1)
    # Allow nonblocking assignments and combinational logic to settle.
    await Timer(1, unit="ns")


def check_gray(dut, expected):
    actual = int(dut.gray_code.value)
    assert actual == expected, (
        f"Expected gray_code={expected:04b}, got {actual:04b}"
    )


@cocotb.test()
async def test_gray_counter(dut):
    clock = Clock(dut.clk, 10, unit="ns")
    cocotb.start_soon(clock.start())

    dut.rst.value = 1
    dut.up_down.value = 1

    # Hold reset for two rising edges, then deassert away from the active edge.
    await ClockCycles(dut.clk, 2)
    await FallingEdge(dut.clk)
    dut.rst.value = 0
    await Timer(1, unit="ns")
    check_gray(dut, 0)

    # Count up: binary 1, 2, 3 -> Gray 1, 3, 2.
    await wait_for_tick(dut)
    check_gray(dut, 0b0001)

    await wait_for_tick(dut)
    check_gray(dut, 0b0011)

    await wait_for_tick(dut)
    check_gray(dut, 0b0010)

    # Change direction away from the rising edge.
    await FallingEdge(dut.clk)
    dut.up_down.value = 0

    # Count down: binary 2 -> Gray 3.
    await wait_for_tick(dut)
    check_gray(dut, 0b0011)

    # Reset and check that the output returns to Gray zero.
    await FallingEdge(dut.clk)
    dut.rst.value = 1
    await ClockCycles(dut.clk, 2)
    await FallingEdge(dut.clk)
    dut.rst.value = 0
    await Timer(1, unit="ns")
    check_gray(dut, 0)



if __name__ == "__main__":
    this_dir = Path(__file__).resolve().parent
    runner = get_runner("icarus")
    runner.build(
        sources=[this_dir / "gray_counter.sv"],
        hdl_toplevel="gray_counter",
        build_dir=this_dir / "sim_build",
        parameters={"LIMIT": LIMIT},
    )
    runner.test(
        hdl_toplevel="gray_counter",
        test_module="test_gray_counter",
    )
