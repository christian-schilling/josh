  $ . ${TESTDIR}/setup_test_env.sh
  $ cd ${TESTTMP}
  $ git clone -q http://localhost:8001/real/repo2.git
  warning: You appear to have cloned an empty repository.
  $ cd repo2
  $ echo ":workspace=sub1" > filter.josh
  $ git add filter.josh
  $ git commit -m "add filter"
  [master (root-commit) 2408650] add filter
   1 file changed, 1 insertion(+)
   create mode 100644 filter.josh
  $ git push
  To http://localhost:8001/real/repo2.git
   * [new branch]      master -> master
  $ cd ${TESTTMP}
  $ git clone -q http://localhost:8001/real_repo.git
  warning: You appear to have cloned an empty repository.
  $ cd real_repo
  $ git status
  On branch master
  
  No commits yet
  
  nothing to commit (create/copy files and use "git add" to track)

  $ mkdir -p sub1/subsub
  $ echo contents1 > sub1/subsub/file1
  $ git add .
  $ git commit -m "add file1"
  [master (root-commit) 03dfdf5] add file1
   1 file changed, 1 insertion(+)
   create mode 100644 sub1/subsub/file1

  $ mkdir sub2
  $ echo contents1 > sub2/file2
  $ git add sub2
  $ git commit -m "add file2"
  [master 79e0ba4] add file2
   1 file changed, 1 insertion(+)
   create mode 100644 sub2/file2

  $ tree
  .
  |-- sub1
  |   `-- subsub
  |       `-- file1
  `-- sub2
      `-- file2
  
  4 directories, 2 files

  $ git log --graph --pretty=%s
  * add file2
  * add file1

  $ git push origin HEAD:refs/heads/master
  To http://localhost:8001/real_repo.git
   * [new branch]      HEAD -> master

  $ cd ${TESTTMP}
  $ git clone -q "http://localhost:8002/real_repo.git:filter('/real/repo2.git@refs/heads/master':/).git" sub1
  remote: Invalid workspace:
  remote: ----
  remote:  --> 1:8
  remote:   |
  remote: 1 | :filter('/real/repo2.git@refs/heads/master':/)
  remote:   |        ^---
  remote:   |
  remote:   = expected EOI, filter_group, filter_subdir, filter_nop, filter_presub, filter, filter_noarg, filter_message, filter_rev, filter_join, filter_replace, or filter_squash
  remote: 
  remote: :filter('/real/repo2.git@refs/heads/master':/)
  remote: ----
  fatal: unable to access 'http://localhost:8002/real_repo.git:filter('/real/repo2.git@refs/heads/master':/).git/': The requested URL returned error: 500
  [128]
  $ cd sub1
  /bin/sh: cd: line 52: can't cd to sub1: No such file or directory
  [2]
  $ tree
  .
  |-- hyper-cgi-test-server.out
  |-- josh-proxy.out
  |-- lfs-content
  |-- lfs.db
  |-- proxy_pid
  |-- real_repo
  |   |-- sub1
  |   |   `-- subsub
  |   |       `-- file1
  |   `-- sub2
  |       `-- file2
  |-- remote
  |   |-- blocked_repo.git
  |   |   |-- HEAD
  |   |   |-- branches
  |   |   |-- config
  |   |   |-- description
  |   |   |-- hooks
  |   |   |   |-- applypatch-msg.sample
  |   |   |   |-- commit-msg.sample
  |   |   |   |-- fsmonitor-watchman.sample
  |   |   |   |-- post-update.sample
  |   |   |   |-- pre-applypatch.sample
  |   |   |   |-- pre-commit.sample
  |   |   |   |-- pre-merge-commit.sample
  |   |   |   |-- pre-push.sample
  |   |   |   |-- pre-rebase.sample
  |   |   |   |-- pre-receive.sample
  |   |   |   |-- prepare-commit-msg.sample
  |   |   |   |-- push-to-checkout.sample
  |   |   |   |-- sendemail-validate.sample
  |   |   |   `-- update.sample
  |   |   |-- info
  |   |   |   `-- exclude
  |   |   |-- objects
  |   |   |   |-- info
  |   |   |   `-- pack
  |   |   `-- refs
  |   |       |-- heads
  |   |       `-- tags
  |   |-- meta_repo.git
  |   |   |-- HEAD
  |   |   |-- branches
  |   |   |-- config
  |   |   |-- description
  |   |   |-- hooks
  |   |   |   |-- applypatch-msg.sample
  |   |   |   |-- commit-msg.sample
  |   |   |   |-- fsmonitor-watchman.sample
  |   |   |   |-- post-update.sample
  |   |   |   |-- pre-applypatch.sample
  |   |   |   |-- pre-commit.sample
  |   |   |   |-- pre-merge-commit.sample
  |   |   |   |-- pre-push.sample
  |   |   |   |-- pre-rebase.sample
  |   |   |   |-- pre-receive.sample
  |   |   |   |-- prepare-commit-msg.sample
  |   |   |   |-- push-to-checkout.sample
  |   |   |   |-- sendemail-validate.sample
  |   |   |   `-- update.sample
  |   |   |-- info
  |   |   |   `-- exclude
  |   |   |-- objects
  |   |   |   |-- info
  |   |   |   `-- pack
  |   |   `-- refs
  |   |       |-- heads
  |   |       `-- tags
  |   |-- real
  |   |   `-- repo2.git
  |   |       |-- HEAD
  |   |       |-- branches
  |   |       |-- config
  |   |       |-- description
  |   |       |-- hooks
  |   |       |   |-- applypatch-msg.sample
  |   |       |   |-- commit-msg.sample
  |   |       |   |-- fsmonitor-watchman.sample
  |   |       |   |-- post-update.sample
  |   |       |   |-- pre-applypatch.sample
  |   |       |   |-- pre-commit.sample
  |   |       |   |-- pre-merge-commit.sample
  |   |       |   |-- pre-push.sample
  |   |       |   |-- pre-rebase.sample
  |   |       |   |-- pre-receive.sample
  |   |       |   |-- prepare-commit-msg.sample
  |   |       |   |-- push-to-checkout.sample
  |   |       |   |-- sendemail-validate.sample
  |   |       |   `-- update.sample
  |   |       |-- info
  |   |       |   `-- exclude
  |   |       |-- objects
  |   |       |   |-- 24
  |   |       |   |   `-- 086502472f82cb4e2df6a85ffaf3258afa56d4
  |   |       |   |-- a7
  |   |       |   |   `-- 4c2626aecdeccc49ca31d91aba7327a630e97c
  |   |       |   |-- da
  |   |       |   |   `-- a61b36d7c651681654e21c40f0bf50c06113eb
  |   |       |   |-- info
  |   |       |   `-- pack
  |   |       `-- refs
  |   |           |-- heads
  |   |           |   `-- master
  |   |           `-- tags
  |   |-- real_repo.git
  |   |   |-- HEAD
  |   |   |-- branches
  |   |   |-- config
  |   |   |-- description
  |   |   |-- hooks
  |   |   |   |-- applypatch-msg.sample
  |   |   |   |-- commit-msg.sample
  |   |   |   |-- fsmonitor-watchman.sample
  |   |   |   |-- post-update.sample
  |   |   |   |-- pre-applypatch.sample
  |   |   |   |-- pre-commit.sample
  |   |   |   |-- pre-merge-commit.sample
  |   |   |   |-- pre-push.sample
  |   |   |   |-- pre-rebase.sample
  |   |   |   |-- pre-receive.sample
  |   |   |   |-- prepare-commit-msg.sample
  |   |   |   |-- push-to-checkout.sample
  |   |   |   |-- sendemail-validate.sample
  |   |   |   `-- update.sample
  |   |   |-- info
  |   |   |   `-- exclude
  |   |   |-- objects
  |   |   |   |-- 03
  |   |   |   |   `-- dfdf502bbb4622e74f4e5794dbc1ea91b3617c
  |   |   |   |-- 3d
  |   |   |   |   `-- 77ff51363c9825cc2a221fc0ba5a883a1a2c72
  |   |   |   |-- 43
  |   |   |   |   `-- 52611a9e7c56dfdfeadec043ced6d6ef7a5c33
  |   |   |   |-- 78
  |   |   |   |   `-- 2f6261fa32f8bfec7b89f77bb5cce40c4611cb
  |   |   |   |-- 79
  |   |   |   |   `-- e0ba46b1d4838b2b50e4b05c2e420e4dca0fd7
  |   |   |   |-- 85
  |   |   |   |   `-- 837e6104d0a81b944c067e16ddc83c7a38739f
  |   |   |   |-- a0
  |   |   |   |   `-- 24003ee1acc6bf70318a46e7b6df651b9dc246
  |   |   |   |-- f5
  |   |   |   |   `-- 386e2d5fba005c1589dcbd9735fa1896af637c
  |   |   |   |-- info
  |   |   |   `-- pack
  |   |   `-- refs
  |   |       |-- heads
  |   |       |   `-- master
  |   |       `-- tags
  |   `-- scratch
  |       |-- josh
  |       |   `-- 22
  |       |       `-- sled
  |       |           |-- blobs
  |       |           |-- conf
  |       |           `-- db
  |       |-- mirror
  |       |   |-- HEAD
  |       |   |-- config
  |       |   |-- description
  |       |   |-- info
  |       |   |   `-- exclude
  |       |   |-- objects
  |       |   |   |-- info
  |       |   |   `-- pack
  |       |   `-- refs
  |       |       |-- heads
  |       |       `-- tags
  |       `-- overlay
  |           |-- HEAD
  |           |-- config
  |           |-- description
  |           |-- hooks
  |           |   |-- pre-receive -> /opt/cache/cargo-target/debug/josh-proxy
  |           |   `-- update -> /opt/cache/cargo-target/debug/josh-proxy
  |           |-- info
  |           |   `-- exclude
  |           |-- objects
  |           |   |-- info
  |           |   `-- pack
  |           `-- refs
  |               |-- heads
  |               `-- tags
  |-- repo2
  |   `-- filter.josh
  `-- server_pid
  
  82 directories, 105 files

  $ git log --graph --pretty=%s master
  fatal: not a git repository (or any of the parent directories): .git
  [128]

  $ echo "file3 content" > file3
  $ git add file3
  fatal: not a git repository (or any of the parent directories): .git
  [128]
  $ git commit -m "add file3"
  fatal: not a git repository (or any of the parent directories): .git
  [128]
  $ git push http://localhost:8001/real/repo2.git HEAD:refs/heads/change1
  fatal: not a git repository (or any of the parent directories): .git
  [128]

  $ cd ${TESTTMP}/real_repo

  $ git fetch --all
  $ git fetch http://localhost:8001/real/repo2.git refs/heads/master:refs/heads/filtermaster
  warning: no common commits
  From http://localhost:8001/real/repo2
   * [new branch]      master     -> filtermaster
  $ git fetch http://localhost:8001/real/repo2.git refs/heads/change1:refs/heads/change1
  fatal: couldn't find remote ref refs/heads/change1
  [128]

  $ git show refs/heads/filtermaster
  commit 24086502472f82cb4e2df6a85ffaf3258afa56d4
  Author: Josh <josh@example.com>
  Date:   Thu Apr 7 22:13:13 2005 +0000
  
      add filter
  
  diff --git a/filter.josh b/filter.josh
  new file mode 100644
  index 0000000..a74c262
  --- /dev/null
  +++ b/filter.josh
  @@ -0,0 +1 @@
  +:workspace=sub1
  $ git show refs/heads/change1
  fatal: ambiguous argument 'refs/heads/change1': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  [128]

  $ git fetch "http://localhost:8002/real_repo.git:join('/real/repo2.git@refs/heads/change1':filter('/real/repo2.git@refs/heads/master':/)).git" refs/heads/master:refs/heads/joined
  remote: Invalid workspace:
  remote: ----
  remote:  --> 1:50
  remote:   |
  remote: 1 | :join('/real/repo2.git@refs/heads/change1':filter('/real/repo2.git@refs/heads/master':/))
  remote:   |                                                  ^---
  remote:   |
  remote:   = expected filter_group, filter_subdir, filter_nop, filter_presub, filter, filter_noarg, filter_message, filter_rev, filter_join, filter_replace, or filter_squash
  remote: 
  remote: :join('/real/repo2.git@refs/heads/change1':filter('/real/repo2.git@refs/heads/master':/))
  remote: ----
  fatal: unable to access 'http://localhost:8002/real_repo.git:join('/real/repo2.git@refs/heads/change1':filter('/real/repo2.git@refs/heads/master':/)).git/': The requested URL returned error: 500
  [128]
  $ git log --graph --pretty=%s refs/heads/joined
  fatal: ambiguous argument 'refs/heads/joined': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'
  [128]
  $ echo hello1
  hello1



  $ bash ${TESTDIR}/destroy_test_env.sh
  .
  |-- josh
  |   `-- 22
  |       `-- sled
  |           |-- blobs
  |           |-- conf
  |           `-- db
  |-- mirror
  |   |-- HEAD
  |   |-- config
  |   |-- description
  |   |-- info
  |   |   `-- exclude
  |   |-- objects
  |   |   |-- info
  |   |   `-- pack
  |   `-- refs
  |       |-- heads
  |       `-- tags
  `-- overlay
      |-- HEAD
      |-- config
      |-- description
      |-- info
      |   `-- exclude
      |-- objects
      |   |-- info
      |   `-- pack
      `-- refs
          |-- heads
          `-- tags
  
  21 directories, 10 files
