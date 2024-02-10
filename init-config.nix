let 
system = builtins.currentSystem;
user = builtins.getEnv "USER";
home = builtins.getEnv "HOME";
in
''
user = "${user}"
home = "${home}"
system = "${system}"
githubUsername = "vedant-pandey"
email = "vedantpandey46@gmail.com"
fullName = "Vedant Pandey"
''
