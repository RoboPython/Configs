import XMonad
import XMonad.Hooks.Script
import XMonad.Hooks.DynamicLog
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
 
main = xmonad  =<< statusBar myBar myPP toggleStrutsKey myConfig

myBar = "xmobar"
myPP = xmobarPP { ppCurrent = xmobarColor "#8DAC03" "" . wrap "<" ">", ppTitle = xmobarColor "#8DAC03" "" . shorten 70}
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = defaultConfig
	{ 
		terminal = "terminator"
		, focusedBorderColor = "#8DAC03"
		, borderWidth = 2
		, focusFollowsMouse = False 
		, logHook = dynamicLog >> updatePointer (Relative 0.95 0.95)
		, manageHook = myManageHook <+> manageDocks
		, startupHook = spawn "~/.xmonad/autostart"
	}
myManageHook = composeAll
	[
		className =? "Xfce4-notifyd" --> doIgnore
		, className =? "Gitk" --> doShift "3"
		, className =? "Skype" --> doShift "4"
		, className =? "Thunderbird" --> doShift "4"
		, className =? "Xephyr" --> doShift "9"
	]
