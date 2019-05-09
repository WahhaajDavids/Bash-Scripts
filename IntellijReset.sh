#!/usr/bin/env bash

echo "removeing evaluation key"
rm ~/.IntelliJIdea15/config/eval/idea15.evaluation.key

echo "resetting evalsprt in options.xml"
sed -i '/evlsprt/d' ~/.IntelliJIdea15/config/options/options.xml

echo "resetting evalsprt in prefs.xml"
sed -i '/evlsprt/d' ~/.java/.userPrefs/prefs.xml


## or:
#For IntelliJ IDEA 2017.1.2 EAP on Windows 10, I had to:
#
#Go to ´~/.IntelliJIdea2017.1/config´
#Remove the folder ´eval´
#Edit file options/options.xml and remove all properties that the name begins with evlsprt, such as:
#<property name="evlsprt3.171" value="18" />
#Go to Windows Registry and under subkeys of HKCU\Software\JavaSoft\Prefs\jetbrains\idea delete keys that begin with evlsprt

