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

  For files that have varying file extensions
  or need extra processing,
  these files will need to be modified also:

  - ~/.recoll/mimeconf

  - ~/.recoll/recoll.conf

    Specifically ``indexedmimetypes``

- Run ``make`` and observe there are now 2 matches.

  (If there isn't debug until there is.)
