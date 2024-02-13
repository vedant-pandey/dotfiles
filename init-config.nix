let 
system = builtins.currentSystem;
user = builtins.getEnv "USER";
home = builtins.getEnv "HOME";
systemType = builtins.elemAt (builtins.split "-" system) 2;
in
''
user = "${user}"
home = "${home}"
system = "${system}"
githubUsername = "vedant-pandey"
email = "vedantpandey46@gmail.com"
fullName = "Vedant Pandey"
isMac = ${if systemType == "darwin" then "true" else "false"}
''
