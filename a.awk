/*S1100000B80000000083C001FFC975F9C3FA*/
/^S1/ {c=substr($0,9,length($0)-8-2); for(i=1;i<length(c);i+=2){ printf substr(c,i,2) " "}; printf "\n" } 
