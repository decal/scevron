# The scevron project by Derek Callaway <decal (AT) ethernet {DOT} org> Jan 2015
SCan EVerything with ruby RONin (Derbycon 4.0 "Family Rootz" Code)

* cpanel-enum-pwnam.rb - Enumerate over usernames from the local UNIX passwd
                         file in order to evoke responses from the getpwnam()
			 info leak (i.e. struct passwd from /usr/include/pwd.h).

* incapsula-host-dump.rb - Extract DNS hostnames of web sites that have 
                           registered themselves with the Incapsula IaaS WAF.  
