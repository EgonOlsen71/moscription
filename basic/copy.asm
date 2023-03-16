*=1024

jmp savescreen
jmp restorescreen

restorescreen:
jsr disable
lda #<52224
sta to1+1
lda #>52224
sta to1+2

lda #<$f000
sta from1+1
lda #>$f000
sta from1+2

lda #<55296
sta to2+1
lda #>55296
sta to2+2

lda #<$f400
sta from2+1
lda #>$f400
sta from2+2
jmp copyscreen

savescreen:
jsr disable
lda #<52224
sta from1+1
lda #>52224
sta from1+2

lda #<$f000
sta to1+1
lda #>$f000
sta to1+2

lda #<55296
sta from2+1
lda #>55296
sta from2+2

lda #<$f400
sta to2+1
lda #>$f400
sta to2+2

copyscreen:

ldy #4
ldx #0

screenloop:

from1:
lda $ffff,x
to1:
sta $ffff,x
from2:
lda $ffff,x
to2:
sta $ffff,x
inx
bne screenloop
inc from1+2
inc from2+2
inc to1+2
inc to2+2
dey
bne screenloop
jmp enable

disable:
lda 1
sta 2
sei
and #253
sta 1
rts

enable:
lda 2
sta 1
cli
rts



