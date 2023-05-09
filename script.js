function reportForm(){

    if(document.getElementById("title").value === ""){
        alert("Invalid input:\nPlease enter a title for the issue.");
        document.getElementById("title").focus();
        return false;
    }
    else if(document.getElementById("subCategory").value === ""){
        alert("Invalid input:\nPlease select a category for the issue.");
        document.getElementById("subCategory").focus();
        return false;
    }
    else if(document.getElementById("location").value === ""){
        alert("Invalid input:\nPlease enter a location for the issue.");
        document.getElementById("location").focus();
        return false;
    }
    else{
        return true;
    }
}

function addUserForm(){
    var emailReg = /^([a-zA-Z]|\d|["])([a-zA-Z!#$%&'*+=?^_`{}|.-]|\d){1,62}([a-zA-Z]|\d|["])[@]([a-zA-Z]|\d)([a-zA-Z]|\d|[.]|[-]){1,252}[.]([a-zA-Z]|\d|[.]){2,62}[a-zA-Z]$/;
    var email = document.getElementById("email").value;
    if(document.getElementById("firstName").value === ""){
        alert("Invalid input:\nPlease enter a First Name for the user.");
        document.getElementById("firstName").focus();
        return false;
    }
    else if(document.getElementById("lastName").value === ""){
        alert("Invalid input:\nPlease enter a Last Name for the user.");
        document.getElementById("lastName").focus();
        return false;
    }
    else if(!email.match(emailReg)){
        alert("Invalid input:\nPlease enter a valid email address for the user.");
        document.getElementById("email").focus();
        return false;
    }
    else if(document.getElementById("password").value === ""){
        alert("Invalid input:\nPlease enter a password for the user.");
        document.getElementById("password").focus();
        return false;
    }
    else if(document.getElementById("phoneNumber").value === ""){
        alert("Invalid input:\nPlease enter a phone number for the user.");
        document.getElementById("phoneNumber").focus();
        return false;
    }
    else if(document.getElementById("role").value === ""){
        alert("Invalid input:\nPlease enter a role for the user.");
        document.getElementById("role").focus();
        return false;
    }
    else{
        return true;
    }
}

function editUserValdation(){
}

function commentValidation(){

    if(document.getElementById("newComment").value === ""){
        alert("Invalid input:\nPlease enter a body for your comment before posting.");
        document.getElementById("newComment").focus();
        return false;
    }
    else{
        return true;
    }
}

function commentValidationA(){

    if(document.getElementById("newCommentA").value === ""){
        alert("Invalid input:\nPlease enter a body for your comment before posting.");
        document.getElementById("newCommentA").focus();
        return false;
    }
    else{
        return true;
    }
}

function commentValidationB(){

    if(document.getElementById("newCommentB").value === ""){
        alert("Invalid input:\nPlease enter a body for your comment before posting.");
        document.getElementById("newCommentB").focus();
        return false;
    }
    else{
        return true;
    }
}

function commentValidationC(){

    if(document.getElementById("newCommentC").value === ""){
        alert("Invalid input:\nPlease enter a body for your comment before posting.");
        document.getElementById("newCommentC").focus();
        return false;
    }
    else{
        return true;
    }
}


function resolveValidation(){
    if(document.getElementById("resolveIssue").value === ""){
        alert("Invalid input:\nPlease enter your resolution details before resolving issue.");
        document.getElementById("resolveIssue").focus();
        return false;
    }
    else{
        return true;
    }
}

function networkValidation(){
    if(document.getElementById("browser").value === ""){
        alert("Invalid input:\nPlease enter your current browser name.");
        document.getElementById("browser").focus();
        return false;
    }
    else if(document.getElementById("browserVer").value === ""){
        alert("Invalid input:\nPlease enter your current browser version.");
        document.getElementById("browserVer").focus();
        return false;
    }
    else if(!(document.getElementById("exTrue").checked || document.getElementById("exfalse").checked) ){
        alert("Invalid input:\nPlease select if external sites are working.");
        return false;
    }
    else if(document.getElementById("errorMessageN").value === ""){
        alert("Invalid input:\nPlease enter the error message you received. If you did not receive a message, please specify.");
        document.getElementById("errorMessageN").focus();
        return false;
    }
    else if(!(document.getElementById("cable").checked || document.getElementById("wifi").checked)){
        alert("Invalid input:\nPlease select the type of internet connection the device uses.");
        return false;
    }
    else if(document.getElementById("wifi").checked && document.getElementById("levelWifiConnection").value === ""){
        alert("Invalid input:\nPlease select the strength of Wifi connection your device receives.");
        return false;
    }
    else if(document.getElementById("numDevicesEffected").value <=0 || document.getElementById("numDevicesEffected").value === ""){
        alert("Invalid input:\nAt least 1 or more devices must be effected.");
        document.getElementById("numDevicesEffected").focus();
        return false;
    }
    else if(!(document.getElementById("inTrue").checked || document.getElementById("inFalse").checked) ){
        alert("Invalid input:\nPlease select if internal sites are working.");
        return false;
    }
    else{
        return true;
    }
}

function softwareValidation(){
    if(document.getElementById("problemApplication").value === ""){
        alert("Invalid input:\nPlease provide the name of the problem application.");
        document.getElementById("problemApplication").focus();
        return false;
    }
    else if(document.getElementById("versionApplication").value === ""){
        alert("Invalid input:\nPlease provide the version of the problem application.");
        document.getElementById("versionApplication").focus();
        return false;
    }
    else if(document.getElementById("operatingSystemS").value === ""){
        alert("Invalid input:\nPlease provide information on the device's operating system.");
        document.getElementById("operatingSystemS").focus();
        return false;
    }
    else{
        return true;
    }
}

function cPowerValidation(){
    if(document.getElementById("makeModelC").value === ""){
        alert("Invalid input:\nPlease provide the make and model of the device.");
        document.getElementById("makeModelC").focus();
        return false;
    }
    else if(document.getElementById("ageC").value <0 || document.getElementById("ageC").value === ""){
        alert("Invalid input:\nPlease provide the age of the device.");
        document.getElementById("ageC").focus();
        return false;
    }
    else if(document.getElementById("sounds").value === ""){
        alert("Invalid input:\nPlease provide information on any sounds the device makes.");
        document.getElementById("sounds").focus();
        return false;
    }
    else if(document.getElementById("startup").value === ""){
        alert("Invalid input:\nPlease provide any details on the startup of the device.");
        document.getElementById("startup").focus();
        return false;
    }
    else{
        return true;
    }
}

function bScreenValidation(){
    if(document.getElementById("makeModelB").value === ""){
        alert("Invalid input:\nPlease provide the make and model of the device.");
        document.getElementById("makeModelB").focus();
        return false;
    }
    else if(document.getElementById("ageB").value <0 || document.getElementById("ageB").value === ""){
        alert("Invalid input:\nPlease provide the age of the device.");
        document.getElementById("ageB").focus();
        return false;
    }
    else if(document.getElementById("operatingSystem").value === ""){
        alert("Invalid input:\nPlease provide information on the device's operating system.");
        document.getElementById("operatingSystem").focus();
        return false;
    }
    else if(document.getElementById("priorBlueScreen").value === ""){
        alert("Invalid input:\nPlease provide information on the events prior to the 'blue screen'.");
        document.getElementById("priorBlueScreen").focus();
        return false;
    }
    else if(document.getElementById("response").value === ""){
        alert("Invalid input:\nPlease provide information on the device's responsiveness.");
        document.getElementById("response").focus();
        return false;
    }
    else{
        return true;
    }
}

function dDriveValidation(){
    if(document.getElementById("makeModel").value === ""){
        alert("Invalid input:\nPlease provide the make and model of the device.");
        document.getElementById("makeModel").focus();
        return false;
    }
    else if(document.getElementById("age").value <0 || document.getElementById("age").value === ""){
        alert("Invalid input:\nPlease provide the age of the device.");
        document.getElementById("age").focus();
        return false;
    }
    else if(document.getElementById("errorMessage").value === ""){
        alert("Invalid input:\nPlease provide the error Message received. If no error message was received please specify.");
        document.getElementById("errorMessage").focus();
        return false;
    }
    else{
        return true;
    }
}

function peripheralValidation(){
    if(document.getElementById("peripheralsEffected").value === ""){
        alert("Invalid input:\nPlease provide the peripherals effected by the device.");
        document.getElementById("peripheralsEffected").focus();
        return false;
    }
    else if(document.getElementById("peripheralConnectionType").value === ""){
        alert("Invalid input:\nPlease specify the type of connection to the peripheral device.");
        document.getElementById("peripheralConnectionType").focus();
        return false;
    }
    else{
        return true;
    }
}

function emailValidation(){
    if(document.getElementById("emailApp").value === ""){
        alert("Invalid input:\nPlease specify the email application being used.");
        document.getElementById("emailApp").focus();
        return false;
    }
    else if(document.getElementById("emailAppVersion").value === ""){
        alert("Invalid input:\nPlease provide the version of the email application being used.");
        document.getElementById("emailAppVersion").focus();
        return false;
    }
    else{
        return true;
    }
}

function spamValidation(){
    if(document.getElementById("spamAddress").value === ""){
        alert("Invalid input:\nPlease provide the suspect email address.");
        document.getElementById("spamAddress").focus();
        return false;
    }
    else if(!(document.getElementById("malicious").checked || document.getElementById("ads").checked || document.getElementById("repeated").checked)){
        alert("Invalid input:\nPlease specify a category for the suspect email.");
        return false;
    }
    else{
        return true;
    }
}

function  detailsValidation(){
    if(document.getElementById("details").value === ""){
        alert("Invalid input:\nPlease fill out all fields.");
        document.getElementById("details").focus();
        return false;
    }
    else return true;
}

function passwordValidation(){
    if(document.getElementById("password").value === ""){
        alert("Invalid input:\nPlease provide your desired password.");
        document.getElementById("password").focus();
        return false;
    }
    else{
        return true;
    }
}