# LUTRAM Negative-Edge Write Test over JTAG

Development of this test is in progress.

This test intends to validate whether a write occurs on rising/falling edge depending on
`IS_WCLK_INVERTED`/`IS_CLK_INVERTED` property is set to 1/0, respectively.

With write enable asserted, we can manually set data and clock pins manually to check if the
LUTRAM writes are truly sensitive to their defined edge. To make observation easier, led_o[1:0]
maps to a single output port of each LUTRAM (such that they light if their respective LUTRAM port
is logic-high). An additional LED `led_o[2]` is lit when both LUTRAM ports match and dim when they
differ. Test creator asserts that if both LUTRAMs behave identically, then `led_o[2]` will remain
lit throughout the examination, indicating that the writes occur on the same edge regardless of the
property.

## Block Diagram

TODO

## Default FPGA Target

By default, this test currently targets SQRL Acorn CLE215(+) with Digilent HS2 JTAG cable.

## Supporting a New Target

The main requirements are the following:

- 7-series Xilinx FPGA board with at least 3 LEDs
- JTAG cable (supported by OpenOCD)
- OpenOCD + telnet client 

To support a new target:
- create an XDC constraint file mapping 3 LEDs to `led_o[2:0]` with appropriate IOSTANDARD
- update the `FAMILY`/`PART`/`BOARD`/`JTAG_CABLE`/`XDC` variables in the
  Makefile or run make overriding them as in the following example:

```
make FAMILY=kintex7 PART=xc7k325tffg900-2 BOARD=kc705 JTAG_CABLE=digilent XDC=kc705.xdc ...
```

## Selecting LUTRAM and Generating the Bitstream

### Using Vivado Toolchain

To generate the bitstream with a specified LUTRAM cell using the Vivado toolchain, run the following:

```
make [PART=...] [XDC=...] LUTRAM=<LUTRAM_TYPE> vivadoclean top.vivado.bit
```

Available `LUTRAM_TYPE` options:

- Supported by Vivado:
    - RAMS32
    - RAMD32
    - RAMS64E
    - RAMD64E
    - RAM32X1S
    - RAM64X1S
    - RAM128X1S
    - RAM256X1S
    - RAM32X1D
    - RAM64X1D
    - RAM128X1D
    - RAM32M
    - RAM64M

### Using OpenXC7 Toolchain

To generate the bitstream with a specified LUTRAM cell using the OpenXC7 toolchain, run the following:

```
make [FAMILY=...] [PART=...] [XDC=...] LUTRAM=<LUTRAM_TYPE> clean top.bit
```

Available `LUTRAM_TYPE` options:

- Supported by OpenXC7/NextPNR:
    - RAM32X1D
    - RAM64X1D
    - RAM128X1D
    - RAM32M
    - RAM64M
- Not yet supported by OpenXC7/NextPNR:
    - RAMS32
    - RAMD32
    - RAMS64E
    - RAMD64E
    - RAM32X1S
    - RAM64X1S
    - RAM128X1S
    - RAM256X1S

## Programming the Target

> [!NOTE]
> OpenOCD will be used to load the generated bitstream onto the CLE215(+) in place of openFPGALoader.
>
> All other BOARD targets will continue to use openFPGALoader for loading the bitstream.
>
> See the [Makefile](./Makefile) and [openXC7.mk](../../openXC7.mk) for more information.

To load the bitstream built with openXC7 onto the target, run the following:

```
make [BOARD=...] [JTAG_CABLE=...] program
```

To load the bitstream built with vivado onto the target, run the following:

```
make [BOARD=...] [JTAG_CABLE=...] BITSTREAM=top.vivado.bit program
```

## Testing LUTRAM with OpenOCD

Start OpenOCD session with an interface script (such as [`digilent-hs2.cfg`](./digilent-hs2.cfg))
and [`setup.cfg`](./setup.cfg) loaded:

```
# Load existing interface adapter script from openocd
openocd -f interface/ADAPTER.cfg -f ./setup.cfg
# Local Digilent HS2 interface script
openocd -f ./digilent-hs2.cfg -f ./setup.cfg
```

Access OpenOCD shell via telnet session at localhost port 4444:

```
$ telnet 0.0.0.0 4444
Trying 0.0.0.0...
Escape character is '^]'.
Open On-Chip Debugger
>
```

[`setup.cfg`](./setup.cfg) defines the following command for configuring LUTRAM:

- `set_lutram <we data clk>` : manually set write enable, data, and clock pins of both LUTRAM

> [!NOTE]
> To not violate setup/hold requirements, set either we+data or clk, but not change both we+data
> and clk together.

## License

This work is licensed under [BSD 3-Clause license](../../LICENSE).
