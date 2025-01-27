format ELF64
public _start

include "asmlib/input.inc"
include "asmlib/math.inc"
include "asmlib/print.inc"
include "asmlib/string.inc"
include "asmlib/sys.inc"

section '.text' executable
_start:
    call input_number
    call goldbach
    call print_enter
    call exit