#SingleInstance force

; based on
; Volume On-Screen-Display (OSD) -- by Rajat
; http://www.autohotkey.com/docs/scripts/VolumeOSD.htm

;_________________________________________________
;_______User Settings_____________________________

; Make customisation only in this area or hotkey area only!!

; How long to display the volume level bar graphs:
vol_DisplayTime = 1000

; Bar's screen position.  Use -1 to center the bar in that dimension:
vol_PosX = -1
vol_PosY = -1
vol_Width = 250  ; width of bar
vol_Thick = 12   ; thickness of bar

;___________________________________________
;_____Auto Execute Section__________________

; DON'T CHANGE ANYTHING HERE (unless you know what you're doing).

vol_BarOptionsMaster = 1:B ZH%vol_Thick% ZX0 ZY0 W%vol_Width% CBRed CWSilver

; If the X,Y positions have been specified, add it to the options.
; Otherwise, omit them to have them centered automatically:
if vol_PosX >= 0
	vol_BarOptionsMaster = %vol_BarOptionsMaster% X%vol_PosX%
if vol_PosY >= 0
	vol_BarOptionsMaster = %vol_BarOptionsMaster% Y%vol_PosY%

exponent = 1.1
vMySlider = 0
bottomText = 0
create()

*Volume_Up::		setVol(exponent)
*Volume_Down::	setVol(1/exponent)
#j::Reload

;___________________________________________




setVol(multiplier)
{
	global
	SoundGet v_old
	before := v_old
	if (v_old < 0.001 && multiplier > 1)
		v_new := 0.01
	else
		v_new := v_old*multiplier
	if (v_new > 100)
		v_new := 100

	;SendInput {Volume_Mute}
	;SendInput {Volume_Mute}
	;v_tmp := v_old
	;while (v_tmp == v_old)
	;	SoundGet v_tmp
	
	SoundSet, v_new
	;showOSD(v)
	
	;Gui, Add, Text,, Please enter your name:
	;Gui, Add, Edit,
	;Gui, Add, Text,, %v_new%
	;GuiControl, Text, %v_new%
	;GuiControl, Progress,, asd, +10
	show(v_new)
}

create()
{
	global
	Gui, -Caption +AlwaysOnTop +Disabled -SysMenu +Owner
	Gui, Color, 000000
	Gui, Font, s10, Tahoma
	Gui, Add, Text, vMyText cFFFFFF +Center, 100
	Gui, Add, Slider, vMySlider x20 y12 h95 cWhite +Vertical +Center +Invert +NoTicks Thick20 Buddy2MyText
	Gui, Margin, 19, 33
}

show(v)
{
	Gui, Show, x50 y60, volume
	GuiControl,, MySlider, %v%
	volString := Format("{1:.0f}", v)
	GuiControl,, MyText, %volString%
	
	SetTimer, hide, 1000
}
hide()
{
	Gui, Hide
	SetTimer, hide, Off
}

showOSD(v)
{
	global

	; prevent flashing when creating new windows
	IfWinNotExist, master_volume
		Progress, %vol_BarOptionsMaster%, , , master_volume

	Progress, 1:%v%
	SetTimer, hideOSD, %vol_DisplayTime%
}

hideOSD()
{
	Progress, 1:Off
	SetTimer, hideOSD, Off
}
