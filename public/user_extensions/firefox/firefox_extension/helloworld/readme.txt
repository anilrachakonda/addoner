You can use its contents as a starting point for developing extensions.

Steps to register:
-----------------

1. Unzip this package(downloaded xpi package) to any location, e.g. c:\dev

2. Put the path to the "helloworld" folder (e.g. c:\dev\helloworld) in the 
    "helloworld@mozilla.doslash.org" file and move that file to 
    [profile folder]\extensions\(e.g /.mozilla/firefox/extensions/)

3. Restart Firefox.

You should see a new "Hello world" item in the Tools menu and the extension
should show up in the Extension Manager window (Tools > Extensions).



Extension.xpi contains working prebuilt version of the extension, just in case.

You must change the following items before making your extension 
available to general public:
1) the extension's ID in install.rdf (helloworld@mozilla.doslash.org).
  (For details see <https://developer.mozilla.org/en/install.rdf>)
2) the extension's short name (currently "helloworld"). 
  The new name must be in lower case.


NOTE: Open install.rdf file and check <em:minVersion> and <em:maxVersion> under <em:targetApplication> and replace <em:minVersion> and <em:maxVersion> values with your firefox version number.
