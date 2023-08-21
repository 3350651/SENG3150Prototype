
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

    else if(document.forms["simpleSearchForm"]["flexibleDate"].value === true
            && (document.forms["simpleSearchForm"]["flexibleDays"].value === ""
            || document.forms["simpleSearchForm"]["flexibleDays"].value == null)
    ){
        alert("A number of days this search should be flexible by needs to be provided.");
        return false;
    }

    else if((document.forms["simpleSearchForm"]["numberOfAdults"].value === ""
             || document.forms["simpleSearchForm"]["numberOfAdults"].value == null) &&
             (document.forms["simpleSearchForm"]["numberOfChildren"].value === ""
             || document.forms["simpleSearchForm"]["numberOfChildren"].value == null)){
        alert("A number of passengers needs to be provided.");
        return false;
    }

        return true;
}

function validateCardForm(){

    let x = document.forms["paymentForm"]["cardNumber"].value;
    let a = document.forms["paymentForm"]["expiry"].value;
    let b = document.forms["paymentForm"]["security"].value;

    if (x.length > 16 || x.length < 16)
    {
        alert("Credit Card number must be 16 characters long.")
        return false;
    }

    if (a.length > 5 || a.length < 5)
    {
        alert("Expiry date must be 5 characters long (including '/').")
        return false;
    }

    if (!a.includes('/'))
    {
        alert("Expiry date entered in the incorrect format.")
        return false;
    }

    if (b.length > 3 || b.length < 3)
    {
        alert("Security number must be 3 characters long.")
        return false;
    }

    //if (x.value.match(/^[a-zA-Z]/))
    //{
      //  alert("Expiry date cannot contain letters.");
        //return false;
    //}

    //if (a.value.match(/^[a-zA-Z]/))
    //{
      //  alert("Expiry date cannot contain letters.");
       // return false;
    //}


    //if (b.value.match(/^[a-zA-Z]/))
    //{
      //  alert("Expiry date cannot contain letters.");
        //return false;
    //}

}