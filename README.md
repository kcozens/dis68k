# dis68k

_dis68k_ is a public domain disassembler for the 68000 by W. de Waal,
originally developed in 1991 and written in era-appropriate unstandardised C.
It was released into the public domain in 1993.

This fork of dis68k was forked from the fork created by Thomas Harte. The
Thomas Harte fork seeked to modernise the original source code written by
W. de Waal:
* to ensure that it builds with modern compilers;
* to give it normative command-line invocation; and
* where possible, to adapt the code to utilise more modern language constructs.

## Usage

    dis68k < file.rom > disassembly.txt

This disassembler reads from stdin and writes to stdout. You can therefore
use the usual means of composition to disassemble directly from compressed
files and/or to compress the output: `zcar file.gz | dis68k > disassembly.txt`
or similar.

By default the disassembler will assume that the input begins at address 0
and that execution begins at address 0. You can modify that assumption with
a map file.

### Map Files

Example map file:

    romstart = FC0000
    FC0000,byte
    FC0030,code
    FF0000,end

This says:

1. the input file data should be located at address `FC0000`.
2. treat the region starting at `FF0000` and ending at `FC002F` as bytes.
3. treat the region starting at `FC0030` and ending at `FEFFFF` as code.
4. stop processing any more data upon reaching address FF0000.

The region types that can be specified are:
    byte, word, long, text, rsvd, code, and end.

Use rsvd to skip a region of memory where the contents don't matter.
Use end to mark the end of the input data. The address specified, and
all later data, will not be decoded and included in the output.

Map files are specified to the disassembler using the `-m` option, e.g.

    dis68k -m file.map < file.rom > disassembly.txt
