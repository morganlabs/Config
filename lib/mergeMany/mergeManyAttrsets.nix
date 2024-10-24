{ lib }: attrsets: builtins.foldl' (acc: set: lib.attrsets.recursiveUpdate acc set) { } attrsets
