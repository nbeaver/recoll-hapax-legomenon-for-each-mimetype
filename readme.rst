How to add a new mimetype:

- Determine the mimetype with ``xdg-mime query filetype example.myfile``.

  Example::

      $ xdg-mime query filetype HelloWorld.java 
      text/x-java

- Edit ``generate-files.sh`` to make a new example file.

  Example::

      unique_word=$(get_unique_word)
      cat << EOF > ${out_dir}/${base_filename}.java
      public class HelloWorld
      {
      	public static void main(String[] args)
      	{
      		System.out.print("${unique_word}");
      		System.out.println();
      	}
      }
      EOF
      printf "${unique_word}\n" >> ${hapax_list}

- Check that the output is a valid example.

  Example::

      $ cat out/hapax_legomenon.java 
      public class HelloWorld
      {
              public static void main(String[] args)
              {
                      System.out.print("cahutecdekciefdiodjofubrajwenn");
                      System.out.println();
              }
      }

- Run ``make`` and observe there is only 1 match for the example.

- Edit Recoll config files.

  If extension is always the same,
  and it needs to be indexed as plaintext,
  this is sufficient::

      $ edit ~/.recoll/mimemap
      # Add this line:
      .java = text/plain

  However, this means that a Recoll search for
  ``mime:text/x-java`` will yield no results.
  To keep the mimetype, do this::

      $ edit ~/.recoll/mimemap
      # Add this line:
      .java = text/x-java
      $ edit ~/.recoll/mimeconf
      # Add this line:
      text/x-java = internal text/plain
      $ edit ~/.recoll/recoll.conf
      # Add 'text/x-java' to 'indexedmimetypes'

  For files that have varying file extensions,
  such as C++, markdown, or gnuplot,
  use this::

      $ edit ~/.recoll/mimemap
      # Add these lines:
      .cc  = text/x-c++src
      .cpp = text/x-c++src
      .cxx = text/x-c++src
      $ edit ~/.recoll/mimeconf
      # Add this line:
      text/x-c++src = internal text/plain
      $ edit ~/.recoll/recoll.conf
      # Add 'text/x-c++src' to 'indexedmimetypes'

  For files that cannot need extra processing,
  e.g. if they are compressed,
  see ``/usr/share/recoll/examples/mimeconf``.

  For files that don't have a consistent file extension,
  such as man pages,
  
  .. TODO: finish this

- Run ``make`` and observe there are now 2 matches.

  (If there isn't debug until there is.)
