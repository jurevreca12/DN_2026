from pathlib import Path
import cocotb
import logging
from cocotb.triggers import Timer
from cocotb_tools.runner import get_runner


control2str = {
    0: "ADD",
    1: "SUB",
    2: "AND",
    3: "OR ",
    4: "XOR",
    5: "EQ ",
    6: "A  ",
    7: "B  "
}

@cocotb.test()
async def test_alu(dut):
    logger = logging.getLogger("cocotb.test_alu")
    # Each tuple is: (a, b, expected results for control 0 through 7)
    test_cases = [
        (3,  2,  [5,  1,  2,  3,  1,  0, 3, 2]),
        (7,  7,  [14, 0,  7,  7,  0,  1, 7, 7]),
        (15, 1,  [0, 14, 1, 15, 14, 0, 15, 1]),
        (10, 12, [6, 14, 8, 14, 6,  0, 10, 12]),
    ]

    for a, b, expected_results in test_cases:
        dut.a.value = a
        dut.b.value = b

        for control, expected in enumerate(expected_results):
            dut.alu_control.value = control
            await Timer(1, unit="ns")

            actual = int(dut.c.value)
            logger.info(f"a={a:3} b={b:3} control={control2str[control]} expected={expected:3} actual={actual:3}")

            assert actual == expected, (
                f"Expected {expected}, got {actual}"
            )

    

if __name__ == "__main__":
    this_dir = Path(__file__).resolve().parent
    runner = get_runner("icarus")
    runner.build(
        sources=[this_dir / "alu.sv"],
        hdl_toplevel="alu",
        build_dir=this_dir / "sim_build",
    )
    runner.test(
        hdl_toplevel="alu",
        test_module="test_alu",
    )

