import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Tabbed
import XMonad.Prompt.ConfirmPrompt
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Actions.PhysicalScreens
import qualified XMonad.StackSet as W

import qualified DBus as D
import qualified DBus.Client as D
import qualified Codec.Binary.UTF8.String as UTF8

import System.Directory
import System.IO

main :: IO ()
main = do
  colors <- getWalColors
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.Log")
    [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

  xmonad $ ewmh $ docks $ def
    {
      logHook = dynamicLogWithPP (mLogHook dbus colors)
    , terminal = "kitty"
    , borderWidth = 0
    , layoutHook = mHookLayout
    , manageHook = manageDocks <+> manageHook defaultConfig
    , startupHook = mStartupHook
    }
   `additionalKeysP` mKeys
   `removeKeysP` mRemoveKeys

dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str = do
    let signal = (D.signal objectPath interfaceName memberName) {
            D.signalBody = [D.toVariant $ UTF8.decodeString str]
        }
    D.emit dbus signal
  where
    objectPath = D.objectPath_ "/org/xmonad/Log"
    interfaceName = D.interfaceName_ "org.xmonad.Log"
    memberName = D.memberName_ "Update"

getConfigFilePath f =
  getHomeDirectory >>= \hd -> return $ hd ++ "/" ++ f

getWalColors = do
  file <- getConfigFilePath ".cache/wal/colors"
  contents <- readFile file
  let colors = lines contents
  return (colors ++ (replicate (16 - length colors) "#000000"))

mLogHook dbus colors = def
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{B" ++ colors!!2 ++ "} ") " %{B-}"
    , ppVisible = wrap ("%{B" ++ colors!!1 ++ "} ") " %{B-}"
    , ppUrgent = wrap ("%{F" ++ colors!!5 ++ "} ") " %{F-}"
    , ppHidden = wrap " " " "
    , ppWsSep = " "
    , ppTitle = const ""
    , ppLayout = const ""
    }

mHookLayout = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $ avoidStruts $ mLayout

mLayout = main ||| full ||| tabbed ||| threeCol
  where
    main = Tall 1 (3/100) (3/5)
    full = Full
    threeCol = ThreeColMid  (1) (3/100) (1/2)
    tabbed = tabbed shrinkText 
    defaultTheme {
    activeBorderColor = "#7C7C7C",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
    }

mKeys =
  [ ("M-S-f"  , spawn "firefox" )
  , ("M-S-<Space>", spawn "$HOME/dotfiles/xmonad/keyboard_layout cycle us fr ru")
  , ("M-/", spawn "playerctl play-pause -p spotify")
  , ("M-o", spawn "source ~/dotfiles/nnn/env.sh && kitty nnn -e")
  , ("M-S-s", spawn "rofi -show p -modi p:~/dotfiles/rofi/rofi-power -theme ~/dotfiles/rofi/config.rasi -lines 6~/dotfiles/rofi/rofi-power")
  , ("M-p", spawn "rofi -show drun -theme ~/dotfiles/rofi/config.rasi")
  , ("M-w", onPrevNeighbour horizontalScreenOrderer W.view)
  , ("M-e", onNextNeighbour horizontalScreenOrderer W.view)
  ]

mRemoveKeys =
  [ "M-S-q"
  , "M-S-e"
  , "M-w"
  , "M-S-w"
  ]

mStartupHook = do
  --spawn "$HOME/dotfiles/polybar/launch.sh"
  spawn "picom --config $HOME/dotfiles/picom.conf"
  spawn "wal -R"
  spawn "~/dotfiles/i3/keyboard_layout set us"
  spawn "xrandr --output HDMI-1 --left-of eDP-1"
  spawn "xset s off"
  spawn "xset -dpms"
  spawn "xset s noblank"
