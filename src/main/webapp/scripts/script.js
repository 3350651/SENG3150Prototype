
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

function toggleVisibility(id, event) {
    event.preventDefault();
    closeTicketSelection(id);
    var x = document.getElementById(id);
     if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
}

function test() {
}

function toggleVisibility2(id, type, button, event) {
    event.preventDefault();
    var headerID = id + 'classDiv';
    var header = document.getElementById(headerID);
    var btns = header.getElementsByClassName("classButton");
    for (var i = 0; i < btns.length; i++) {
        var current = document.getElementsByClassName("classButtonActive");
        if (btns[i].classList.contains("classButtonActive")) {
            btns[i].className = btns[i].className.replace(" classButtonActive", "");
        }
    }
    button.className += " classButtonActive";

    closeTicketSelection(id);
    var newID = id + '' + type;
    var x = document.getElementById(newID);
    if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
}

function closeTicketSelection(id) {
    varEco = id + 'ECO';
    varEcoDiv = document.getElementById(varEco)
    varEcoDiv.style.display = "none";

    varPme = id + 'PME';
    varPmeDiv = document.getElementById(varPme)
    varPmeDiv.style.display = "none";

    varBus = id + 'BUS';
    varBusDiv = document.getElementById(varBus)
    varBusDiv.style.display = "none";

    varFir = id + 'FIR';
    varFirDiv = document.getElementById(varFir)
    varFirDiv.style.display = "none";
}

function selectPrice(passenger, isReturn, id, price, classCode, ticketType, event) {
    event.preventDefault();

    var spanID = 'priceFor-' + passenger + '-' + isReturn + '-' + id;
    var spanElem = document.getElementById(spanID);
    spanElem.innerHTML = 'SELECTED PRICE: ' + price;

    var inputPrice = passenger + '-' + isReturn + '-price-' + id;
    document.forms['passengerDetails'][inputPrice].value = price;

    var total = 0;

    var className = passenger + 'falsetotal';
    var prices = document.getElementsByClassName(className);

    for (var i = 0; i < prices.length; i++) {
        if(!isNaN(parseFloat(prices[i].value))) {
            total = total + parseFloat(prices[i].value);
        }
    }

    var className = passenger + 'truetotal';
    var prices = document.getElementsByClassName(className);
    for (var i = 0; i < prices.length; i++) {
        if(!isNaN(parseFloat(prices[i].value))) {
            total = total + parseFloat(prices[i].value);
        }
    }

    var grandTotal = passenger + 'total';
    var totalSpan = document.getElementById(grandTotal);
    totalSpan.innerHTML = total;


    var inputClassCode = passenger + '-' + isReturn + '-class-' + id;
    document.forms['passengerDetails'][inputClassCode].value = classCode;

    var inputTicketType = passenger + '-' + isReturn + '-type-' + id;
    document.forms['passengerDetails'][inputTicketType].value = ticketType;

    document.forms['passengerDetails'][grandTotal].value = total;

    var newID = passenger + '-' + isReturn + '-' + id;
    toggleVisibility(newID, event);
}

function validateRandomDestForm(){
    if(document.forms["randomDestinationForm"]["departureLocation"].value === ""){
        alert("Please select a departure destination.");
        return false;
    }
    else if((document.forms["randomDestinationForm"]["numberOfAdults"].value !== "" && document.forms["randomDestinationForm"]["numberOfAdults"].value <= 0) ||
    (document.forms["randomDestinationForm"]["numberOfChildren"].value !== "" && document.forms["randomDestinationForm"]["numberOfChildren"].value <= 0)){
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