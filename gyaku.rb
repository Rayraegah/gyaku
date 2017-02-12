#!/usr/bin/env ruby

# gyaku.rb
# 0.0.1
# deobfuscate minified code from sourcemaps

require 'open-uri'
require 'pathname'
require 'json'

def prune(f)
  ext = f.extname

  if ext.include?("?")
    f.sub_ext(ext.split("?").first)
  else
    f
  end
end

sourcemap_url   = ARGV[0] or "USAGE: [ruby] gyaku.rb <sourcemap-file-path> [<destination>]"
destination     = ARGV[1]
destination   ||= "./gyaku-bin"

root            = Pathname(destination || "./gyaku-bin").expand_path
sourcemap       = open(sourcemap_url).read
files, contents = JSON(sourcemap).values_at(*%w(sources sourcesContent))

files = files.map { |f| f.sub("~", "./vendor") }
files = files.map { |f| root.join(f).expand_path }
files = files.map { |f| prune(f) }


files.zip(contents).each_with_index do |(bin, src), index|
  bin.dirname.mkpath
  puts "[%4s] \t (%5s) \t WROTE %s" % [index, bin.write(src), bin.relative_path_from(Pathname(".").expand_path)]
end

puts "\nDESTINATION #{root}"