import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.Run
import XMonad.Layout.ThreeColumns
import XMonad.Layout.SimpleDecoration (shrinkText)
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


import Data.Maybe
import Data.Bifunctor
import Data.List as DL
import Data.Char as DC


import System.IO
import System.IO.Unsafe

getFromXres :: String -> IO String
getFromXres key = fromMaybe "" . findValue key <$> runProcessWithInput "xrdb" ["-query"] ""
  where
    findValue :: String -> String -> Maybe String
    findValue xresKey xres =
      snd <$> (
                DL.find ((== xresKey) . fst)
                $ catMaybes
                $ splitAtColon
                <$> lines xres
              )

    splitAtColon :: String -> Maybe (String, String)
    splitAtColon str = splitAtTrimming str <$> (DL.elemIndex ':' str)

    splitAtTrimming :: String -> Int -> (String, String)
    splitAtTrimming str idx = bimap trim trim . (second tail) $ splitAt idx str

    trim :: String -> String
    trim = DL.dropWhileEnd (DC.isSpace) . DL.dropWhile (DC.isSpace)

fromXres :: String -> String
fromXres = unsafePerformIO . getFromXres

main :: IO ()
main = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.Log")
    [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

  xmonad $ ewmh $ docks $ def
    {
      terminal = "kitty"
    , borderWidth = 0
    , layoutHook = mHookLayout
    , manageHook = manageDocks <+> manageHook defaultConfig
    , startupHook = mStartupHook
    , logHook = dynamicLogWithPP (mLogHook dbus)
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

mLogHook dbus = def
    { ppOutput = dbusOutput dbus
    , ppCurrent = wrap ("%{B" ++ fromXres "*.color1" ++ "} ") " %{B-}"
    , ppVisible = wrap ("%{B" ++ fromXres "*.color2" ++ "} ") " %{B-}"
    , ppUrgent = wrap ("%{F" ++ fromXres "*.color5" ++ "} ") " %{F-}"
    , ppHidden = wrap " " " "
    , ppWsSep = " "
    , ppTitle = const " "
    , ppLayout = const ""
    }

mHookLayout = spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True $ avoidStruts $ mLayout

mLayout = main ||| full ||| tabbed shrinkText theme
  where
    main = Tall 1 (3/100) (3/5)
    full = Full
    theme = def {
    fontName = "xft:monospace:size=9"
    , decoHeight = 32
    , activeColor =  "#FF0000" --fromXres "*.color1"
    , inactiveColor = fromXres "*.color2"
    , activeTextColor = "#FF0000" -- fromXres "*.foreground"
    , inactiveTextColor = fromXres "*.foreground"
   }

mKeys =
  [ ("M-S-f"  , spawn "firefox" )
  , ("M-S-<Backspace>", spawn "$HOME/dotfiles/xmonad/keyboard_layout cycle us fr ru")
  , ("M-/", spawn "playerctl play-pause -p spotify")
  , ("M-o", spawn "source ~/dotfiles/nnn/env.sh && kitty nnn -e")
  , ("M-S-s", spawn "rofi -show p -modi p:~/dotfiles/rofi/rofi-power -theme ~/dotfiles/rofi/config.rasi -lines 6~/dotfiles/rofi/rofi-power")
  , ("M-p", spawn "rofi -show drun -theme ~/dotfiles/rofi/config.rasi")
  , ("<Print>", unGrab *> spawn "/usr/local/bin/ss_clipboard.sh")
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
  spawn "$HOME/dotfiles/xmonad/startup.sh"
