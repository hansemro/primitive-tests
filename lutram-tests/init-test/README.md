# LUTRAM INIT Parameter Test

Development of this test is in progress.

This test is intended to validate the INIT of LUT_OR_MEM BELs are being set correctly by the
FASM writer in NextPNR based on the LUTRAM instantiated.

## Manual Verification

Run `make YOSYS_OPTS=-DTEST_<LUTRAM_TYPE> clean top.fasm` to synthesize and implement a design
with the specified LUTRAM cell, then check if INIT parameters are set in `top.fasm`. Steps to
validate the bit patterns for each LUTRAM cell type is not yet provided.

Available `LUTRAM_TYPE` options:

- RAMS32
    - not yet supported by NextPNR
- RAMD32
    - not yet supported by NextPNR
- RAMS64E
    - not yet supported by NextPNR
- RAMD64E
    - not yet supported by NextPNR
- RAM32X1S
    - not yet supported by NextPNR
- RAM64X1S
    - not yet supported by NextPNR
- RAM128X1S
    - not yet supported by NextPNR
- RAM256X1S
    - not yet supported by NextPNR
- RAM32X1D
- RAM64X1D
- RAM128X1D
- RAM32M
- RAM64M
