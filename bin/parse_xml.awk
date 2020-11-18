# { a = "FOO"; print gsub("O", "X", a); print a; exit }



{ 
    if (0) {
        print "# " $0
        print "." $2 "."
        print ""
    }
}


$2 == "Doc"  { doc = $3 }
$2 == "Name" { name = $3 }
$2 == "Val"  { val = $3 }
$2 == "BaseModuleName" { bmname = $3 }
$2 == "/ParameterItem" {
    printf("%s\n", bmname "/" name " (" val "): " doc);
}



# {
#     previndent = indent;
#     indent=$1;          
#     if (($2 == "InstanceName") && (indent != previndent)) {print; next}
#     if (($2 == "InstanceName") && (indent == previndent)) {next}
#     {print}                                     
# }
# 