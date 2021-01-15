#!/usr/bin/env python3

def main():
    print('''
PE Spec is automatically generated each time Genesis2 produces a new
design.  Please make sure that the spec you use matches your design.
Upon generation, the spec is usually placed in the top level Verilog
directory e.g. <tt>CGRAGenerator/hardware/generator_z/top/PE-Spec.md</tt>
''')
    for s in build_sections():
        # if s.label != "pe_flags": continue
        s.print_label()
        print(s.title)
        if not s.auto_generated: print(s.autogen_warning)
        print(s.text)
        print(s.hline)

class Section:
    def __init__(self, autogen, label, title, text):
        self.auto_generated = autogen
        self.label = label
        self.title = title
        self.text  = text
        self.hline = '<!------------------------------------------------------------------>'
        self.autogen_warning='''
##### <i>Note, this section not auto-generated (yet); info may or may not be accurate for your design.<br/></i>
'''
    def print_label(self):
        if self.label: print("<a name='%s'/>\n" % self.label)

def build_sections():
    sections = []
    sections.append(Section(
        autogen=True, # FIXME this is a  LIE!!
        label="TOC",
        title="# Table of Contents",
        text='''\
* [Bitstream Address](#bitstream_address)
    * [Tile Number](#tile_number)
    * [Element Number](#element_number)
    * [Register Number](#register_number)

* [Bitstream Data (PE Instruction) (32-bit "op_code")](#pe_instruction)
    * [PE Instruction Decode, bits 31-16 (PE inputs)](#pe_instruction_decode_31_16)
    * [PE Instruction Decode, bits 15-0  (flags and ops)](#pe_instruction_decode_15_0)
        * [ALU Operations, bits 5-0](#alu_ops)
        * [PE flags, bits 15-12](#pe_flags)
'''
    ))
    sections.append(Section(
        autogen=False,
        label="bitstream_address",
        title="## Bitstream Address",
        text='''\
The CGRA configuration bitstream consists of pairs of 32-bit numbers,
one for address and one for data.  Each pair programs
one "feature" in a tile.  The 32-bit address is decoded as shown:


    +-------+-------+-------+-------+-------+-------+-------+-------+
    | 31         24 | 23         16 | 15                          0 |
    +-------+-------+-------+-------+-------+-------+-------+-------+
    | Reg           |Element/Feature| Tile number (row/column)      |
    +-------+-------+-------+-------+-------+-------+-------+-------+

The bitstream address consists of three elements

- tile number, bits 15-0;
- element (or feature) number, bits 13-16; and
- register number, bits 31-24.

The element number for a PE is 0x00.
'''
    ))
    sections.append(Section(
        autogen=False,
        label="tile_number",
        title="### Tile Number",
        text="""\
**Tile number** (bits 15:0) is composed of eight bits.  The leftmost bit
(MSB, bit 15) tells whether this is a normal tile on te CGRA grid or if it's a
global/virtual tile e.g. a global signal tile (GST).

    +--+--------------+-----------------+
    |15| 14         9 | 8             0 |
    +--+--------------+-----------------+
    |G | Row number   | Column number   |
    +--+--------------+-----------------+

E.g. tile number 0x0809 indicates a tile that lives in row 8 column 9.

Tile numbers e.g. 0x8000, 0xA504 etc. indicate global tiles with no
particular physical placement within the CGRA.
"""
    ))
    sections.append(Section(
        autogen=False,
        label="element_number",
        title="### Element (Feature) Number",
        text='''\
The element number to address a PE is 0x00.  Other numbers usually
indicate the address of a switchbox or connection box within the tile.
'''
    ))
    sections.append(Section(
        autogen=False,
        label="register_number",
        title="### Register Number",
        text="""\
When the element number is 0x00, indicating a PE address, the register
number tells how to decode the data word associated with the address.

| Address<br>[31:24] | Name | Width | Comment |
| ------- | ----------  | ----- | ------------------------------------------------------ |
|  8'h00  | lut_code    |    8  | LUT content. Defines the function for 1bit LUT output. |
|  8'hFF  | op_code     |   32  | Configures 16bit ALU, see below for opcodes            |
|  8'hF0  | data0_const |   16  | Sets the value of the data0 register in REG_CONST mode |
|  8'hF1  | data1_const |   16  | Sets the value of the data1 register in REG_CONST mode |
|  8'hF2  | Reserved    |       |                                                        |
|  8'hF3  | bit0_const  |    1  | Sets the value of the bit0 register in REG_CONST mode |
|  8'hF4  | bit1_const  |    1  | Sets the value of the bit1 register in REG_CONST mode |
|  8'hF5  | bit2_const  |    1  | Sets the value of the bit2 register in REG_CONST mode |
|  8'hE0  | debug_trig  |   16  | Sets the debug trigger value for res |
|  8'hE1  | debug_trig_p|    1  | Sets the debug trigger value for res_p |

In this table, "width" refers to the number of bits in the
configuration data-word used to do the indicated configuration.
E.g. if the bitstream contains the address-data pair

FF000303 00000005

then this would program the PE in tile number 0x0303 with the 32-bit
opcode 0x00000005 (in our current design this would be a multiply
operation).

The remainder of this document addresses how to decode the 32-bit
"op_code".
"""
    ))
    sections.append(Section(
        autogen=True,
        label="pe_instruction",
        title='## Bitstream Data (PE Instruction) (32-bit "op_code")',
        text=""
    ))
    sections.append(Section(
        autogen=False,
        label="pe_instruction_decode_31_16",
        title="### PE Instruction Decode, bits 31-16 (PE inputs)",
        text="""\
The top (most-significant) 16 bits of the PE instruction (bits 31-16
of the 32-bit bitstream data word) indicate modes for each of the PE's
input sources.  Each PE can have three one-bit inputs (in the case
where the PE is programmed as a LUT) or two sixteen-bit inputs (for
ADD, MUL, etc.)  The one-bit inputs are designated *bit0, bit1,* and
*bit2;* the sixteen-bit inputs are *data0* and *data1.*

    +-------+-------+-------+-------+-------+-------+-------+
    | 29:28 | 27:26 | 25:24 | 23:22 | 21:20 | 19:18 | 17:16 |
    +-------+-------+-------+-------+-------+-------+-------+
    | bit2  | bit1  | bit0  |  n/a  |  n/a  | data1 | data0 |
    +-------+-------+-------+-------+-------+-------+-------+


Each input can be programmed to one of four modes according to the two
bits in each field:

| Value | Name       | Comment |
| ----- | ---------- | ------- |
|  2'h0 | REG_CONST  | Output is constant |
|  2'h1 | REG_VALID  | Pipeline delay with clock_en = 'clk_en' |
|  2'h2 | REG_BYPASS | FF is bypassed     |
|  2'h3 | REG_DELAY  | Assumes data is always valid, adds 1 cycle delay |

TODO need an example here I think
"""
    ))
    sections.append(Section(
        autogen=False,
        label="pe_instruction_decode_15_0",
        title="### PE Instruction Decode, bits 15-0 (flags and ops)",
        text="""\
The remaining 16 bits in the lower half of the PE instruction are
decoded as follows:

    +---------------+-----+---+-----+------+---------------+
    |     15:12     |11:10| 9 | 8:7 |  6   |      5:0      |
    +-------+-------+-----+---+-----+------+---------------+
    |    flag_sel   | irq |acc| n/a |signed|   operation   |
    +-------+-------+-----+---+-----+------+---------------+

* flag_sel and operation are explained below, each in its own section
* irq means ...?
* acc - enables accumulation in data1 (operand b) such that 
** b[t+1] = operation(a[t], b[t])
** result = b[t]
* signed tells whether operation is signed (1) or unsigned (0)
"""
    ))

    # Auto-generate op table section
    import gen_optable_md
    sections.append(Section(
        autogen=True,
        label="alu_ops",
        title="#### ALU Operations, bits 5-0",
        text=gen_optable_md.list_opcodes(DBG=0)
    ))

    # Auto-generate op table section
    import gen_flagtable_md
    sections.append(Section(
        autogen=True,
        label="pe_flags",
        title="#### PE flags, bits 15-12",
        text ="\nNote: flags should be same as ARM condition codes (see Appendix A).\n\n" \
               + gen_flagtable_md.gen_flagtable(DBG=0)
    ))

    sections.append(Section(
        autogen=True,
        label="",
        title="",
        text="""\
"""
    ))
    sections.append(Section(
        autogen=False,
        label="ARM_ccodes",
        title="# Appendix A: ARM Condition Codes",
        text="""\
<img src="https://github.com/StanfordAHA/CGRAGenerator/raw/master/doc/arm-ccodes.png" width="600"/>\
"""
    ))
    return sections

def print_optable():
    print('''\
<!------------------------------------------------------------------------>
<a name="alu_ops" />
''')


    import gen_optable_md
    gen_optable_md.main()

def oldmain():
    print_TOC()
    print_hline()
    print_bitstream_address()
    print_tile_number()
    print_element_number()
    print_register_number()
    print_pe_instruction_intro()
    print_pe_instruction_decode()
    print_optable()

# old_main()
main()
