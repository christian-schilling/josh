
  $ export TESTTMP=${PWD}

  $ cd ${TESTTMP}
  $ git init -q repo 1>/dev/null
  $ cd repo

  $ echo "{}" > empty.json
  $ echo "{\"foo\": 123}" > object.json
  $ echo "[7,7,4,123,{\"foo\": 123}]" > list.json
  $ echo "123" > number.json
  $ echo "\"hello\"" > string.json
  $ echo "null" > null.json
  $ echo "true" > bool.json

  $ git add .
  $ git commit -m initial
  [master (root-commit) 6c78fc8] initial
   7 files changed, 7 insertions(+)
   create mode 100644 bool.json
   create mode 100644 empty.json
   create mode 100644 list.json
   create mode 100644 null.json
   create mode 100644 number.json
   create mode 100644 object.json
   create mode 100644 string.json

  $ git diff ${EMPTY_TREE}..refs/heads/master
  diff --git a/bool.json b/bool.json
  new file mode 100644
  index 0000000..27ba77d
  --- /dev/null
  +++ b/bool.json
  @@ -0,0 +1 @@
  +true
  diff --git a/empty.json b/empty.json
  new file mode 100644
  index 0000000..0967ef4
  --- /dev/null
  +++ b/empty.json
  @@ -0,0 +1 @@
  +{}
  diff --git a/list.json b/list.json
  new file mode 100644
  index 0000000..13b570e
  --- /dev/null
  +++ b/list.json
  @@ -0,0 +1 @@
  +[7,7,4,123,{"foo": 123}]
  diff --git a/null.json b/null.json
  new file mode 100644
  index 0000000..19765bd
  --- /dev/null
  +++ b/null.json
  @@ -0,0 +1 @@
  +null
  diff --git a/number.json b/number.json
  new file mode 100644
  index 0000000..190a180
  --- /dev/null
  +++ b/number.json
  @@ -0,0 +1 @@
  +123
  diff --git a/object.json b/object.json
  new file mode 100644
  index 0000000..093c59a
  --- /dev/null
  +++ b/object.json
  @@ -0,0 +1 @@
  +{"foo": 123}
  diff --git a/string.json b/string.json
  new file mode 100644
  index 0000000..3580093
  --- /dev/null
  +++ b/string.json
  @@ -0,0 +1 @@
  +"hello"

  $ josh-filter -p ':json'
  :json
  $ josh-filter --update refs/heads/filtered ':json'

  $ git diff ${EMPTY_TREE}..refs/heads/filtered
  diff --git a/bool.json/bool b/bool.json/bool
  new file mode 100644
  index 0000000..f32a580
  --- /dev/null
  +++ b/bool.json/bool
  @@ -0,0 +1 @@
  +true
  \ No newline at end of file
  diff --git a/list.json/array/0/number b/list.json/array/0/number
  new file mode 100644
  index 0000000..c793025
  --- /dev/null
  +++ b/list.json/array/0/number
  @@ -0,0 +1 @@
  +7
  \ No newline at end of file
  diff --git a/list.json/array/1/number b/list.json/array/1/number
  new file mode 100644
  index 0000000..c793025
  --- /dev/null
  +++ b/list.json/array/1/number
  @@ -0,0 +1 @@
  +7
  \ No newline at end of file
  diff --git a/list.json/array/2/number b/list.json/array/2/number
  new file mode 100644
  index 0000000..bf0d87a
  --- /dev/null
  +++ b/list.json/array/2/number
  @@ -0,0 +1 @@
  +4
  \ No newline at end of file
  diff --git a/list.json/array/3/number b/list.json/array/3/number
  new file mode 100644
  index 0000000..d800886
  --- /dev/null
  +++ b/list.json/array/3/number
  @@ -0,0 +1 @@
  +123
  \ No newline at end of file
  diff --git a/list.json/array/4/object/foo/number b/list.json/array/4/object/foo/number
  new file mode 100644
  index 0000000..d800886
  --- /dev/null
  +++ b/list.json/array/4/object/foo/number
  @@ -0,0 +1 @@
  +123
  \ No newline at end of file
  diff --git a/null.json/null b/null.json/null
  new file mode 100644
  index 0000000..ec747fa
  --- /dev/null
  +++ b/null.json/null
  @@ -0,0 +1 @@
  +null
  \ No newline at end of file
  diff --git a/number.json/number b/number.json/number
  new file mode 100644
  index 0000000..d800886
  --- /dev/null
  +++ b/number.json/number
  @@ -0,0 +1 @@
  +123
  \ No newline at end of file
  diff --git a/object.json/object/foo/number b/object.json/object/foo/number
  new file mode 100644
  index 0000000..d800886
  --- /dev/null
  +++ b/object.json/object/foo/number
  @@ -0,0 +1 @@
  +123
  \ No newline at end of file
  diff --git a/string.json/string b/string.json/string
  new file mode 100644
  index 0000000..b6fc4c6
  --- /dev/null
  +++ b/string.json/string
  @@ -0,0 +1 @@
  +hello
  \ No newline at end of file

$ josh-filter --update refs/heads/filtered --reverse ':replace("hello":"bye","(?m)^(?P<l>.+)$":"$l!")'

$ git diff ${EMPTY_TREE}..refs/heads/master
diff --git a/hw.txt b/hw.txt
new file mode 100644
index 0000000..3b18e51
--- /dev/null
+++ b/hw.txt
@@ -0,0 +1 @@
+hello world
diff --git a/subdir/hw.txt b/subdir/hw.txt
new file mode 100644
index 0000000..1b95c6e
--- /dev/null
+++ b/subdir/hw.txt
@@ -0,0 +1 @@
+hello moon
