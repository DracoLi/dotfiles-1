# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "dracoli"
sudo scutil --set HostName "dracoli"
sudo scutil --set LocalHostName "dracoli"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "dracoli"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Menu bar: hide some icons since I don't use them
# defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Volume.menu" "/System/Library/CoreServices/Menu Extras/TextInput.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable “natural” (Lion-style) scrolling - OMG I hate inverted scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Disable automatic termination of inactive apps
# defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Restart automatically if the computer freezes
# systemsetup -setrestartfreeze on

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true


###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
# defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show all files
# defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder.
chflags nohidden ~/Library

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the /Volumes folder
sudo chflags nohidden /Volumes

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 40

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Hide Safari's bookmark bar.
# defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# Allow installing user scripts via GitHub or Userscripts.org
# defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"
# defaults write com.google.Chrome.canary ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"


###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Finder" "Safari"; do
  killall "$app" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
