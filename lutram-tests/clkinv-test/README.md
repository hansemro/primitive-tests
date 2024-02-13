# LUTRAM CLKINV Property Test

Development of this test is in progress.

This test is intended to validate the CLKINV SLICEM bit is set correctly if the `IS_*CLK_INVERTED`
property for a LUTRAM cell is set.

## XC7 Notes

LUTRAM cells on 7 Series platforms share the same clock inverter with FF elements on the same
SLICEM site.

Design rules:
- All LUTRAMs and FFs in the same site must share the same `IS_*CLK_INVERTED` property as they
  share CLKINV routing BEL.

## XUS/XUS+ Notes

LUTRAM cells on Ultrascale/Ultrascale+ platforms have their own dedicated clock inverter, `LCLKINV`.
This makes it possible to pack LUTRAM and FF BELs with different CLKINV properties.

Design rules:
- All LUTRAMs in the same site must share the same `IS_*CLK_INVERTED` property as they share
  LCLKINV routing BEL.

## Manual Verification

Run `make YOSYS_OPTS=-DTEST_<LUTRAM_TYPE> clean top.fasm` to synthesize and implement a design
with the specified LUTRAM cell, then check if CLKINV SLICEM bit in `top.fasm`. If `NOCLKINV` bit
appears, then the test has failed for that LUTRAM cell.

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
