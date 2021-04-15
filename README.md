# snort_src

This repository includes the steps to install Snort 3 plugins for IEC61850 communication standards. The plugins were created by Simon and modified by Balint.

Snort 3
-------------

Snort 3 version 3.0.3-5 is surely compatible with the most recent plugin version. 

To install Snort 3, follow the instructions at https://github.com/matebalint1/snort_src/blob/master/docs/Snort_3_on_Ubuntu.pdf "Installing Snort" chapter until cloning the Snort 3 repository. It is important to install the libdaq version which can be found in the dependencies folder, otherwise the modification of the main Snort 3 library might be neccesary due to incomplete renaming.

After cloning Snort 3, run `$ git checkout tags/3.0.3-5` to choose the right version (or instead of cloning, simply use the submodule in this repository), then continue the installation process.

Compile times can be shortened by using the command `$ make -j $(nproc)` instead of `$ make` to use all available threads.

At this point Snort 3 version 3.0.3-5 should be installed. Type `$ /usr/local/bin/snort -V` to verify.

Alternatively, up-to-date dependencies and Snort 3 library at the time of writing this guide can be found at https://github.com/matebalint1/snort_src/tree/master/dependencies and https://iai-vcs.iai.kit.edu/usjsb/snort3. Installing Git LFS is neccessary to fetch the dependencies folder.

Snort 3 plugin
-------------

Now follow the instructions in https://github.com/matebalint1/snort_src/blob/master/docs/Snort_3_on_Ubuntu.pdf "Appendix A: Installing Example Plugins", but clone our plugins from https://iai-vcs.iai.kit.edu/usjsb/snort3_extra.git (default master branch, last commit) instead of the original repository.

Configuration files
-------------

With Snort 3 and the plugins installed, use the updated snort.lua and goose.rules files from https://github.com/matebalint1/snort_src/blob/master/lua_files/snort_modified_3035.lua and https://github.com/matebalint1/snort_src/blob/master/lua_files/goose_simon.rules.

Start detection
-------------

Run the following Snort 3 command to start real time detection (using the proper snort.lua and goose.rules files from above):
`$ sudo snort --plugin-path /usr/local/lib/snort_extra -c /usr/local/etc/snort/snort.lua -i lo -R /usr/local/etc/snort/rules/goose.rules --warn-all --pedantic -A alert_fast`

libiec61850 library for testing
-------------

Clone the library https://iai-vcs.iai.kit.edu/usjsb/libiec61850.git, checkout the branch snort_testing.
run:
```
$ make
$ sudo ./examples/goose_publisher/goose_publisher_example lo
$ sudo ./examples/goose_publisher2/goose_publisher_example2 lo
```
to send goose packets with incorrect stNums and sqNums.


Upstream repos at:
-------------

* https://github.com/snort3/snort3
* https://github.com/snort3/snort3_extra
* https://github.com/mz-automation/libiec61850


