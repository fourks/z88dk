;
;	Sharp specific routines
;	by Stefano Bodrato, Fall 2013
;
;	int set_psg(int reg, int val);
;
;	Play a sound by PSG
;
;
;	$Id: set_psg_callee.asm,v 1.5 2016-06-10 21:13:58 dom Exp $
;

        SECTION code_clib
	PUBLIC	set_psg_callee
	PUBLIC	_set_psg_callee

	PUBLIC ASMDISP_SET_PSG_CALLEE

	
set_psg_callee:
_set_psg_callee:

   pop hl
   pop de
   ex (sp),hl
	
.asmentry

    LD	BC,$1C00
	OUT	(C),l

	dec b
	OUT	(C),e
	ret

DEFC ASMDISP_SET_PSG_CALLEE = # asmentry - set_psg_callee

