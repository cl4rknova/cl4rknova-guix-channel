# just a private test. do nout use for now
This has been forked more than less only for private purpose to evaluate the use of private guix repositories. For seiously using this, please go back to https://github.com/flatwhatson/guix-channel


To use the channel, add it to your configuration in
`~/.config/guix/channels.scm`:


``` scheme
(cons* (channel
        (name 'flat)
        (url "https://github.com/cl4rknova/cl4rknova-guix-channel.git")
        (introduction
         (make-channel-introduction
          "60ead0cb6748a1fc4df605c7b021bf99b1458960"
          (openpgp-fingerprint
           "5B85 0A07 DB01 FD6F D9C4  406E 2B52 F213 425A A0D1"))))
       %default-channels)
```

With the channel configured, it can be used as follows:


``` shell
guix pull
guix search emacs-native-comp
guix install emacs-native-comp
```

## License

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program.  If not, see <http://www.gnu.org/licenses/>.

See [COPYING](COPYING) for details.

[guix]: https://guix.gnu.org/
[guix-channel]: https://guix.gnu.org/manual/en/html_node/Channels.html
[gccemacs]: https://www.emacswiki.org/emacs/GccEmacs
[masm11-pgtk]: https://github.com/masm11/emacs/tree/pgtk
[flatwhatson-pgtk]: https://github.com/flatwhatson/emacs/tree/pgtk-nativecomp
