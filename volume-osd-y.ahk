; Volume-OSD-y
; https://github.com/blole/volume-osd-y

#SingleInstance force

exponent := 1.1
create()

*Volume_Up::	setVol(exponent)
*Volume_Down::	setVol(1/exponent)
#j::			Reload



setVol(multiplier)
{
	SoundGet v_old
	
	if (v_old < 0.01 && multiplier > 1)
		v_new := 0.01
	else
		v_new := v_old*multiplier
	if (v_new > 100)
		v_new := 100
	
	SoundSet, v_new
	show(v_new)
}

create()
{
	global
	Gui, -Caption +AlwaysOnTop +Disabled -SysMenu +Owner
	Gui, Color, 000000
	Gui, Font, s10, Tahoma
	Gui, Add, Text, vMyText cFFFFFF +Center, 100
	Gui, Add, Slider, vMySlider x20 y12 h95 +Vertical +Center +Invert +NoTicks Buddy2MyText
	Gui, Margin, 19, 33
}

show(v)
{
	Gui, Show, NoActivate x50 y60, volume
	GuiControl,, MySlider, %v%
	volString := Format("{1:.0f}", v)
	GuiControl,, MyText, %volString%
	
	SetTimer, hide, -1000
}

hide()
{
	Gui, Hide
}
