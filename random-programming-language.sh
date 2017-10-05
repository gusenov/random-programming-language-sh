#!/bin/bash

# https://www.tiobe.com/tiobe-index/

declare -a programming_languages_1=(  # 1..20
# TIOBE Index for September 2017
'Java'
'C'
'C++'
'C#'
'Python'
'PHP'
'JavaScript'
'Visual Basic .NET'
'Perl'
'Ruby'
'R'
'Delphi/Object Pascal'
'Swift'
'Visual Basic'
'Assembly language'
'MATLAB'
'Go'
'Objective-C'
'PL/SQL'
'Scratch'
);

declare -a programming_languages_2=(  # 21..50
# Other programming languages
# The complete top 50 of programming languages is listed below.
'SAS'
'Dart'
'D'
'Transact-SQL'
'ABAP'
'COBOL'
'(Visual) FoxPro'
'Scala'
'Fortran'
'Ada'
'Crystal'
'Erlang'
'Lisp'
'Awk'
'Lua'
'VBScript'
'F#'
'Alice'
'Prolog'
'LabVIEW'
'Logo'
'VHDL'
'Hack'
'Ladder Logic'
'Verilog'
'Apex'
'Julia'
'ML'
'Rust'
'PowerShell'
);

declare -a programming_languages_3=(  # 51..100
# The Next 50 Programming Languages
# The following list of languages denotes #51 to #100.
'4th Dimension/4D'
'ABC'
'ActionScript'
'APL'
'AutoLISP'
'Bash'
'bc'
'Bourne shell'
'C shell'
'CFML'
'CL (OS/400)'
'Clipper'
'Clojure'
'Common Lisp'
'Elixir'
'Elm'
'Euphoria'
'Forth'
'Groovy'
'Haskell'
'Icon'
'IDL'
'Inform'
'Io'
'J'
'Korn shell'
'Kotlin'
'Magic'
'Maple'
'MOO'
'MQL4'
'MUMPS'
'NATURAL'
'NXT-G'
'OCaml'
'OpenCL'
'OpenEdge ABL'
'Oz'
'PL/I'
'PostScript'
'Q'
'REXX'
'Ring'
'RPG (OS/400)'
'Scheme'
'Smalltalk'
'SPARK'
'SPSS'
'Stata'
'Tcl'
);

function random_programming_language()
{
    local file_name=$1 && shift
    
    local programming_languages=("$@")
    #echo ${programming_languages[@]}
    #printf "'%s'\n" "${programming_languages[@]}"
    
    local how_many_programming_languages=${#programming_languages[@]}
    
    if [ -f "$file_name" ]; then
        local num_of_lines=$(wc -l < "$file_name")
        #echo "$num_of_lines"
        if [ "$num_of_lines" -eq "$how_many_programming_languages" ]; then
            rm "./$file_name"
        else
            while read p; do
                
                for i in "${!programming_languages[@]}"; do
                    if [[ ${programming_languages[i]} = "$p" ]]; then
                        unset 'programming_languages[i]'
                    fi
                done
                
            done <"$file_name"
        fi
    fi
    #printf "'%s'\n" "${programming_languages[@]}"
    
    local programming_languages_cnt=${#programming_languages[@]}
    local random_index=$(( RANDOM % $programming_languages_cnt ))  # 0..programming_languages_cnt
    local programming_language=$( echo -n ${programming_languages[@]:$random_index:1} )
    
    echo $programming_language >> "$file_name"
    echo $programming_language
}

for i in "$@"
do
case $i in
    -f|--first)
    random_programming_language "programming_languages_1.txt" "${programming_languages_1[@]}"
    shift
    ;;
    -s|--second)
    random_programming_language "programming_languages_2.txt" "${programming_languages_2[@]}"
    shift
    ;;
    -t|--third)
    random_programming_language "programming_languages_3.txt" "${programming_languages_3[@]}"
    shift
    ;;
    -r|--reset)
    rm "programming_languages_1.txt"
    rm "programming_languages_2.txt"
    rm "programming_languages_3.txt"
    shift
    ;;
esac
done
