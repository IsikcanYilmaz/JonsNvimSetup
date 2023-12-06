function cscope_init() { # https://stackoverflow.com/questions/11917923/how-to-use-cscope-for-a-project-which-has-c-cpp-and-h-files
  # Generate a list of all source files starting from the current directory
  # The -o means logical or
  rm cscope.files cscope.in.out cscope.out cscope.po.out tags
  find $PWD -name "*.c" \
		-o -name "*.cc" \
		-o -name "*.cpp" \
		-o -name "*.h" \
		-o -name "*.hh" \
		-o -name "*.hpp" > cscope.files
  # -q build fast but larger database
  # -R search symbols recursively
  # -b build the database only, don't fire cscope
  # -i file that contains list of file paths to be processed
  # This will generate a few cscope.* files
  cscope -q -R -b -i cscope.files
  # Temporary files, remove them
  # rm -f cscope.files cscope.in.out cscope.po.out
  ctags -R
  echo "The cscope database is generated"
}
# -d don't build database, use kscope_generate explicitly
# alias cscope="cscope -d"

function bear_make()
{
  bear -- make

}

