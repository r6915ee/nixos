# Dotfiles

This directory contains raw dotfiles that get symlinked by the
`mkOutOfStoreSymlin` function to their respective locations. These files are
typically stored here because they cannot be managed by Home Manager, such as
with Niri, which can be used as a session but supports user-specific
configurations that unfortunately cannot be managed by Home Manager.
