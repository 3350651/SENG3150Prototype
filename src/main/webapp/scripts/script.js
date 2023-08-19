
function validateSearchForm(){
    if(document.forms["simpleSearchForm"]["departureLocation"].value === ""){
        alert("A departure location must be provided.");
        return false;
    }

    else if(document.forms["simpleSearchForm"]["arrivalLocation"].value === ""){
        alert("A destination must be provided.");
        return false;
    }

    else if(document.forms["simpleSearchForm"]["departureLocation"].value ===
    document.forms["simpleSearchForm"]["arrivalLocation"].value){
        alert("Search cannot arrive at the same destination it departs.");
        return false;
    }

    else if(document.forms["simpleSearchForm"]["departureDate"].value === ""
            || document.forms["simpleSearchForm"]["departureDate"].value == null){
        alert("A departure time must be provided.");
        return false;
    }

    else if((document.forms["simpleSearchForm"]["flexibleDays"].value === ""
            || document.forms["simpleSearchForm"]["flexibleDays"].value == null
            || document.forms["simpleSearchForm"]["flexibleDays"].value < 0)
    ){
        alert("A positive number of days this search should be flexible by needs to be provided.");
        return false;
    }

    else if((document.forms["simpleSearchForm"]["numberOfAdults"].value === ""
             || document.forms["simpleSearchForm"]["numberOfAdults"].value == null) &&
             (document.forms["simpleSearchForm"]["numberOfChildren"].value === ""
             || document.forms["simpleSearchForm"]["numberOfChildren"].value == null)){
        alert("A number of passengers needs to be provided.");
        return false;
    }
    else if(document.forms["simpleSearchForm"]["numberOfAdults"].value === "0" &&
            document.forms["simpleSearchForm"]["numberOfChildren"].value === "0"){
                alert("A number of passengers needs to be provided.");
                return false;
    }
    else if(isNaN(document.forms["simpleSearchForm"]["numberOfAdults"].value) || document.forms["simpleSearchForm"]["numberOfAdults"].value < 0
    || isNaN(document.forms["simpleSearchForm"]["numberOfChildren"].value) || document.forms["simpleSearchForm"]["numberOfChildren"].value < 0){
        alert("A positive number of passengers needs to be provided.");
        return false;
    }

        return true;
}

function validateRandomDestForm(){
    if(document.forms["randomDestinationForm"]["departureLocation"].value === ""){
        alert("Please select a departure destination.");
        return false;
    }
    else if(document.forms["randomDestinationForm"]["numberOfAdults"].value <= 0 ||
    document.forms["randomDestinationForm"]["numberOfChildren"].value <= 0){
        alert("Only positive values are allowed for passengers");
        return false;
    }
    else{
        return true;
    }
}

function validateTagSearch(){
    if(document.forms["tagSearch"]["tags"].value === null || document.forms["tagSearch"]["tags"].value === ""){
        alert("Please select at least 1 tag for to search by.");
        return false;
    }
    else{
        return true;
    }
}