{
    if(match($0,/Hartman/)){
        first_line = $0;
        getline;
        second_line = $0;
        if(match($0,/TB/)){
            gsub(/Hartman/,"\\textbf{Hartman}",first_line);
            gsub(/T\./,"\\textbf{T.}",second_line);
        }
        print first_line;
        print second_line;
    }else{
        print $0;
    }
}
