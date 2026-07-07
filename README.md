This is a script created for a very specific cleanup project. It does the following:

- Take two inputs: share path and log file path (else it will spit out instructions)
- It will check to make sure the log file, if it exists already, is writeable (because I ran into this specific problem myself)
- It will then check the path and get the owner and group for the path
- It will then write to the log file the file path and also the current POSIX permissions for that path. 
-- Like:  File path: /tmp/root_lab - Owner: root - Group: root - Permissions: 755
-- dashes separate entities, colons separate values. This makes this output very awk'able
- It will then check the path for a sub-directory called Lab. If the sub-directory Lab exists it will write to the log ‘Lab exists’. If the Lab sub-directory does not exists it will create it -m 2770 and -g groupname and write to the log ‘Lab created’
- It will then check the path for a sub-directory called Everyone. If the sub-directory Everyone exists it will write to the log ‘Everyone exists’. If the Everyone sub-directory does not exists it will create it -m 0775 -g groupname and write to the log ‘Everyone created’
