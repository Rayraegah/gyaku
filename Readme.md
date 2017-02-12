# Gyaku

I often reverse engineer minified javascript/css bundles and deobfuscate them. This little ruby script converts `sourcemap` files into source files.

## Usage

    [ruby] gyaku.rb <sourcemap-file-path> [<destination>]

It works with both local files and urls. If destination is not specified it dumps everything into a folder named `gyaku-bin` in cwd.

## No sourcemap?

[jsnice](https://jsnice.org) works well for javascript. You can simply pretty print css.

# License
MIT