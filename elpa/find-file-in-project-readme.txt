This program provides a couple methods for quickly finding any file
in a given project.  It depends on GNU find.

Usage,
  - `M-x find-file-in-project` will start search immediately
  - `M-x find-file-in-project-by-selected` use the your selected
     region as keyword to search. Or you need provide the keyword
     if no region selected.

A project is found by searching up the directory tree until a file
is found that matches `ffip-project-file'.  (".git" by default.)
You can set `ffip-project-root-function' to provide an alternate
function to search for the project root.  By default, it looks only
for files whose names match `ffip-patterns',

If you have so many files that it becomes unwieldy, you can set
`ffip-find-options' to a string which will be passed to the `find'
invocation in order to exclude irrelevant subdirectories/files.
For instance, in a Ruby on Rails project, you are interested in all
.rb files that don't exist in the "vendor" directory.  In that case
you could set `ffip-find-options' to "-not -regex \".*vendor.*\"".

All these variables may be overridden on a per-directory basis in
your .dir-locals.el.  See (info "(Emacs) Directory Variables") for
details.

Ivy.el from https://github.com/abo-abo/swiper could be automatically
used if you insert below line into ~/.emacs,
  (autoload 'ivy-read "ivy")
In Ivy.el, SPACE is translated to regex ".*".
For exmaple, the search string "dec fun pro" is transformed into
a regex "\\(dec\\).*\\(fun\\).*\\(pro\\)"

If Ivy.el is not available, ido will be used.

GNU Find can be installed,
  - through `brew' on OS X
  - through `cygwin' on Windows.

This program works on Windows/Cygwin/Linux/Mac Emacs.
See https://github.com/technomancy/find-file-in-project for advanced tips

Recommended binding: (global-set-key (kbd "C-x f") 'find-file-in-project)
