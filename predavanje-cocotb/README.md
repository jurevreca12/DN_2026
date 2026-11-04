# cocotb in the Anvil environment

Written for: students attending the cocotb tutorial who use the Anvil toolchain.

The examples in this folder (`alu`, `counter`, `matrix_multiplier`, `buggy_fifo`) use **cocotb 2.0 or newer** (e.g. `from cocotb_tools.runner import get_runner`). They do **not** work with cocotb 1.x.

## 1. Activate the virtual environment

cocotb is not installed system-wide. It lives in a Python virtual environment, so you must activate it **in every new terminal**:

```bash
source ~/opt/verif/bin/activate     # activate
deactivate                          # leave the environment when done
```

Your prompt shows `(verif)` while the environment is active. Without it, `import cocotb` fails with `ModuleNotFoundError`, or you get a different cocotb version than expected.

## 2. Check your version

```bash
source ~/opt/verif/bin/activate
python -c "import cocotb; print(cocotb.__version__)"
```

- `2.x`: you are ready.
- `1.x` (the older toolchain ships **1.9.2**): update as described below.

## 3. Update to cocotb 2.x

The `anvil update` command does not yet pick up the new version, because the update is not visible on the Anvil page. Use the fix from the RatkoFRI repository instead:

```bash
git clone https://github.com/RatkoFri/toolchain-setup.git
cd toolchain-setup
./install.sh
```

Then repeat step 2 to confirm you have 2.x. The update removes `forastero`, which is no longer part of the toolchain.

Once the update appears on the Anvil page, `anvil update` will also work.

## 4. Run the examples

Always with the environment active:

```bash
source ~/opt/verif/bin/activate
cd alu              # or counter, matrix_multiplier
make cocotb         # runs the cocotb test (python test_alu.py)
make clean          # removes build artifacts
```

`make run` (without cocotb) simulates the plain SystemVerilog testbench with Icarus Verilog and is useful for comparison.

`matrix_multiplier` has no Makefile. Run it with Python or pytest:

```bash
cd matrix_multiplier
python test_matrix_multiplier.py     # uses Verilator by default (SIM=verilator)
pytest test_matrix_multiplier.py
SIM=icarus python test_matrix_multiplier.py   # choose another simulator
```

## 5. Troubleshooting

| Symptom | Cause / fix |
|---|---|
| `ModuleNotFoundError: No module named 'cocotb'` | Environment not active. Run `source ~/opt/verif/bin/activate`. |
| `ModuleNotFoundError: No module named 'cocotb_tools'` | Old cocotb 1.x. Update (step 3). |
| Prompt has no `(verif)` | Environment not active (new terminal?). |
| Wrong `python` is used | Check with `which python`. It should point into `~/opt/verif/bin/`. |

If problems persist, send the output of `python --version`, `pip list | grep -i cocotb` (with the environment active), and your operating system.
