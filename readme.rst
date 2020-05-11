How to add a new mimetype:

- Determine the mimetype with ``xdg-mime query filetype example.myfile``.

  Example::

      $ xdg-mime query filetype HelloWorld.java
      text/x-java

- Add a new example file in ``templates/``
  that contains the ``${unique_word}`` string.

  Example::

      public class HelloWorld
      {
      	public static void main(String[] args)
      	{
      		System.out.print("${unique_word}");
      		System.out.println();
      	}
      }

- Generate the output files.

  Run ``make generate-files`` or do it manually::

      python3 generate_files.py --debug templates/ out/

- Check that the output is a valid example.

  Example::

      $ cat out/hapax_legomenon.java
      public class HelloWorld
      {
              public static void main(String[] args)
              {
                      System.out.print("vlgnevkwbowbsxqdpbsbpkpoxxwntp");
                      System.out.println();
              }
      }
      $ xdg-mime query filetype out/hapax_legomenon.java
      text/x-java

- Run ``make`` and observe there is only 1 match for the example.

  ::

      Recoll query: Query((hapax_legomenon.java AND vlgnevkwbowbsxqdpbsbpkpoxxwntp))
      1 results
      text/plain	[file:///home/nathaniel/Dropbox/archive/2019/personal/software/name/recoll/hapax-legomenon-for-each-mimetype/out/hapax_list.txt]	[hapax_list.txt]	2971	bytes


  This shows that ``recoll`` does have the unique word in its index,
  but it has not indexed the ``.java`` file.

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
  such as man pages, we rely on ``xdg-mime`` to find.

- Run ``make`` and observe there are now 2 matches.

  ::

      Recoll query: Query((hapax_legomenon.java AND vlgnevkwbowbsxqdpbsbpkpoxxwntp))
      2 results
      text/x-java	[file:///home/nathaniel/Dropbox/archive/2019/personal/software/name/recoll/hapax-legomenon-for-each-mimetype/out/hapax_legomenon.java]	[hapax_legomenon.java]	152	bytes
      text/plain	[file:///home/nathaniel/Dropbox/archive/2019/personal/software/name/recoll/hapax-legomenon-for-each-mimetype/out/hapax_list.txt]	[hapax_list.txt]	2971	bytes

  (If there isn't debug until there is.)
