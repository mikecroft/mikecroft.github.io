---
layout: post
title: Linux WPA WiFi configuration
comments: true
tags:
  - i3
  - linux
  - config
---

I'm a big fan of using the terminal over using a GUI. Ostensibly, that's because it tends to be more efficient to avoid reaching for the mouse so often, and to script as much as possible. In reality, this results in an excessive amount of time spent in configuring, reconfiguring, changing colourschemes and generally fiddling with useless settings when I could be getting things done.

Recently, I've switched my window manager in Xubuntu to i3, which seemed natural, since it's much more focused around the command line. Also, i3-gaps is a good way to make things look pretty, and there's a whole **world** of settings to spend my evenings messing with.

In the course of getting i3 to play nicely with Xubuntu, I found that most things worked pretty much straight away. I also found that it was very easy to break things.

One thing I managed to break was my WiFi connection, which didn't resume properly after I suspended my desktop. Since the whole point was to resume my session where I left off, I didn't want to just restart so I set about finding out how to fix it. The guide which got me there was from [blackmoreops](http://www.blackmoreops.com/2014/09/18/connect-to-wifi-network-from-command-line-in-linux/). Rather than reproduce that very helpful blog, I'll just summarise the key commands which helped me, but it's certainly worth reading the full blog to get an understanding of what is going on.

I already knew my WiFi interface details, SSID name and found that using `ip link` to bring up my wlan0 interface didn't actually work and wasn't needed in the end anyway, so the following starts from step 6:

    # Set a passphrase for the SSID CompuGlobalHyperMegaNet
    wpa_passphrase CompuGlobalHyperMegaNet >> /etc/wpa_supplicant.conf
    <password>
    
    # Connect to the SSID
    wpa_supplicant -B -D wext -i wlan0 -c /etc/wpa_supplicant.conf
    
    # Verify the connection
    iw wlan0 link

At this point, everything worked! Initially, my i3status reported I was connected with no IP, but before I could use `dhclient wlan0` to get a DHCP allocated IP address, I was already set up.
